<?php

namespace Model;

use Cool\DBManager;

class UsersManager {

    public function register($username, $email, $birthdate, $password, $password_repeat) 
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
        $request = $pdo->prepare("INSERT INTO `users` (`id`, `name`, `email`, `password`, `birthdate`, `profile_pic_url`) VALUES (NULL, '" . $username . "', '" . $email . "', '" . password_hash($password, PASSWORD_DEFAULT) . "', '" . $birthdate . "', '" . NULL . "')");

        $email_verif = $pdo->prepare("SELECT `email` FROM `users` WHERE `email` = '$email'");
        $email_verif->execute();
        $isEmailUsed = $email_verif->fetch();

        $is_username_taken = $pdo->prepare("SELECT `name` FROM `users` WHERE `username` = '$username'");
        $is_username_taken->execute();
        $username_taken = $is_username_taken->fetch();
        if ($isEmailUsed['email'] === $email) {
            $errors['email'] = 'You already have an account';
            $sendForm = false;
        }

        if ($username_taken['username'] === $username) {
            $errors['username'] = 'This username is already taken';
            $sendForm = false;
        }

        if ($sendForm === true) {
            $request->execute();
            self::login($email, $password);
            header('Location: /home');
            exit();
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
        } else {
            if (password_verify($password, $data['password'])) {
                $_SESSION['user'] = $data;
                $_SESSION['is_user_on'] = 'on';
                $id = $data['id'];
                $update_last_login = $pdo->query("UPDATE `users` SET `last_login` = NOW() WHERE `id` = '" . $id . "'");
                header('Location: /home');
                exit();
            } else {
                $errors['error'] = 'Invalid email or password';
                return $errors;
            }
        }   
    }
}