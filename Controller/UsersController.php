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
            if (isset($_POST['change-pic-btn'])) {
                $type = $_FILES['pic']['type'];
                $size = $_FILES['pic']['size'];
                $name = $_FILES['pic']['name'];
                $tmp_name = $_FILES['pic']['tmp_name'];
                $errors = [];
                if($type !== 'image/png' && $type !== 'image/jpg' && $type !== 'image/jpeg') {
                    $errors['type'] = 'You can only upload png/jpg/jpeg files';
                } else {
                    $change_pic = new UsersManager();
                    $change_pic->changePic($name, $tmp_name, $type, $size);
                }
            }
            $data = [
                'user' => $_SESSION,
            ];
        }
        return $this->render('profile.html.twig', $data);
    }

    public function followAction() {
        $manager = new UsersManager();
        $manager->follow($_POST['follower'], $_POST['followed']);
        die(var_dump('<pre>', $_POST));
    }
}
