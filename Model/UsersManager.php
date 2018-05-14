<?php

namespace Model;

use Cool\DBManager;

class UsersManager {

    public function register($username, $email, $password, $password_repeat) 
    {
        $errors = [];
        $sendForm = true;

        if ($password !== $password_repeat) {
            $sendForm = false;
        }

        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        $request = $pdo->prepare("INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES (NULL, :name, :email, :password)"); // ADD PROFILE PIC URL
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);
        $request->bindParam(':name', $username);
        $request->bindParam(':email', $email);
        $request->bindParam(':password', $hashed_password);

        $email_verif = $pdo->prepare("SELECT `email` FROM `users` WHERE `email` = '$email'");
        $email_verif->execute();
        $isEmailUsed = $email_verif->fetch();

        $is_username_taken = $pdo->prepare("SELECT `name` FROM `users` WHERE `name` = '$username'");
        $is_username_taken->execute();
        $username_taken = $is_username_taken->fetch();
        if ($isEmailUsed['email'] === $email) {
            $errors['email'] = 'You already have an account';
            $errors['status'] = false;
            $sendForm = false;
        }

        if ($username_taken['name'] === $username) {
            $errors['username'] = 'This username is already taken';
            $errors['status'] = false;
            $sendForm = false;
        }

        if ($sendForm === true) {
            $errors['status'] = true;
            $request->execute();
            self::login($email, $password);
            return $errors;
        }else {
            return $errors;
        }
    }

    public function login($email, $password)
    {
        $errors = [];
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->query("SELECT * FROM `users` WHERE `email` ='" . $email . "'");
        $data = $request->fetch(\PDO::FETCH_ASSOC);
        if (empty($data)) {
            $errors['email'] = 'Invalid email';
            $errors['status'] = false;
            return $errors;
        }else {
            if (password_verify($password, $data['password'])) {
                $_SESSION = $data;
                $id = $data['id'];
                $update_last_login = $pdo->query("UPDATE `users` SET `last_login` = NOW() WHERE `id` = '" . $id . "'");
                $errors['status'] = true;
                return $errors;
            } else {
                $errors['password'] = 'Invalid password';
                $errors['status'] = false;
                return $errors;
            }
        }   
    }

    public function changePic($name, $tmp_name, $type, $size) {
        $new_pp = '/assets/pp/' . basename($name);
        if (is_uploaded_file($tmp_name)){
            $dbManager = DBManager::getInstance();
            $pdo = $dbManager->getPdo();
            $stmt = $pdo->query("SELECT users.pp_url FROM users WHERE users.id = '".$_SESSION['id']."'");
            $old_pp_url = $stmt->fetch();
            if (!empty($old_pp_url['pp_url'])){
                unlink($_SERVER['DOCUMENT_ROOT'] . $old_pp_url['pp_url']);
            }
            if (move_uploaded_file($tmp_name, $_SERVER['DOCUMENT_ROOT'] . $new_pp)) {
                $request = $pdo->prepare("UPDATE users SET users.pp_url = :pp_url WHERE users.id = :id");
                $request->bindParam(':pp_url', $new_pp);
                $request->bindParam(':id', $_SESSION['id']);
                $request->execute();
                $_SESSION['pp_url'] = $new_pp;
                header('Location: /profile');
                exit();
            } else {
                    $errors['upload'] = 'Error uploading file please retry';
            }
        } else {
            $errors['upload'] = 'Error uploading file please retry';
        }
    }

    public function follow($follower, $followed)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        $request = $pdo->prepare("INSERT INTO `follows` (`id`, `follower`, `followed`) VALUES (NULL, :follower, :followed);");
        $request->bindParam(':follower', $follower);
        $request->bindParam(':followed', $followed);
        $request->execute();
    }

    public function unfollow($follower, $followed)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        $request = $pdo->prepare("DELETE FROM `follows` WHERE `follows`.`follower` = :follower AND `follows`.`followed` = :followed");
        $request->bindParam(':follower', $follower);
        $request->bindParam(':followed', $followed);
        $request->execute();
    }

    public function isAlreadyFollowed($follower, $followed)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT * FROM `follows` WHERE `follows`.`follower` = '$follower' AND `follows`.`followed` = '$followed'")->fetch(\PDO::FETCH_ASSOC);
    }

    public function findUserById($user_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT * FROM `users` WHERE `users`.`id` = '$user_id'")->fetch(\PDO::FETCH_ASSOC);
    }

    public function getUserInfo($user)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT * FROM `users` WHERE `users`.`name` = '$user'")->fetch(\PDO::FETCH_ASSOC);
    }

    public function getUserFollowers($user)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT COUNT(*) AS followers FROM follows WHERE follows.followed = '$user'")->fetch(\PDO::FETCH_ASSOC)['followers'];
    }

    public function getUserFollowings($user)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT COUNT(*) AS followings FROM follows WHERE follows.follower = '$user'")->fetch(\PDO::FETCH_ASSOC)['followings'];
    }
}