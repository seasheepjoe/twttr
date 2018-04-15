<?php

namespace Controller;

use Cool\BaseController;
use Model\UsersManager;

class UsersController extends BaseController
{

    public function registerAction() 
    {
        if (isset($_SESSION['name'])) {
            header('Location: /');
            exit();
        } else {
            $data = [];
            if (isset($_POST['username']) && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['password-repeat'])) {
                $username = htmlentities($_POST['username']);
                $email = htmlentities($_POST['email']);
                $password = htmlentities($_POST['password']);
                $password_repeat = htmlentities($_POST['password-repeat']);
                $users_manager = new UsersManager();
                $errors = $users_manager->register($username, $email, $password, $password_repeat);
                $data = [
                    'errors' => $errors,
                ];
            }
            return $this->render('register.html.twig', $data);
        }
    }

    public function loginAction()
    {
        if (isset($_SESSION['name'])) {
            header('Location: /');
            exit();
        } else {
            $data = [];
            if (isset($_POST['email']) && isset($_POST['password'])) {
                $email = htmlentities($_POST['email']);
                $password = htmlentities($_POST['password']);
                $account_manager = new UsersManager();
                $errors = $account_manager->login($email, $password);
                $data = [
                    'errors' => $errors,
                ];
            }
            return $this->render('login.html.twig', $data);
        }
    }

    public function logoutAction() 
    {
        session_destroy();
        header('Location: /');
        exit();
    }

    public function profileAction()
    {
        if (!isset($_SESSION['name'])) {
            header('Location: /');
            exit();
        } else {
            $data = [
                'user' => $_SESSION,
            ];
        }
        return $this->render('profile.html.twig', $data);
    }
}
