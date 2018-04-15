<?php

namespace Model;

use Cool\DBManager;

class UsersManager {

    public function register($username, $email, $password, $password_repeat) 
    {
        $errors = [];
        $sendForm = true;

        if (strlen($username) <= 2 || strlen($username) > 25) {
            $errors['username'] = 'Le nom d\'utilisateur doit faire entre 3 et 25 charactères';
            $sendForm = false;
        }

        if (strlen($password) <= 5 || strlen($password) > 15) {
            $errors['password'] = 'Le mot de passe doit faire entre 6 et 25 charactères';
            $sendForm = false;
        }

        if ($password !== $password_repeat) {
            $errors['password_repeat'] = 'Veuillez taper le même mot de passe';
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
            $sendForm = false;
        }

        if ($username_taken['name'] === $username) {
            $errors['username'] = 'This username is already taken';
            $sendForm = false;
        }

        if ($sendForm === true) {
            $request->execute();
            self::login($email, $password);
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
        $data = $request->fetch();
        if (empty($data)) {
            $errors['error'] = 'Invalid email or password';
            return $errors;
        }else {
            if (password_verify($password, $data['password'])) {
                $_SESSION = $data;
                $id = $data['id'];
                $update_last_login = $pdo->query("UPDATE `users` SET `last_login` = NOW() WHERE `id` = '" . $id . "'");
                header('Location: /');
                exit();
            } else {
                $errors['error'] = 'Invalid email or password';
                return $errors;
            }
        }   
    }

    public function changePic($name, $tmp_name, $type, $size) {
        $url = './assets/pp/' . $_SESSION['id'] . '_pp.';
        $new_pp =  $url . substr($type, 6);
        if (is_uploaded_file($tmp_name)){
            $dbManager = DBManager::getInstance();
            $pdo = $dbManager->getPdo();
            $stmt = $pdo->query("SELECT users.pp_url FROM users WHERE users.id = '".$_SESSION['id']."'");
            $old_pp_url = $stmt->fetch();
            if (!empty($old_pp_url['pp_url'])){
                unlink($old_pp_url['pp_url']);
            }
            if (move_uploaded_file($tmp_name, $new_pp)) {
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
}