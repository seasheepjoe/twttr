<?php

namespace Controller;

use Cool\BaseController;
use Model\UsersManager;
use Model\TwttsManager;

class UsersController extends BaseController
{

    public function registerAction() 
    {
        if (isset($_SESSION['name'])) {
            header('Location: /');
            exit();
        } else {
            $data = json_decode(file_get_contents('php://input'));
            if (!empty($data) && isset($data->name) && isset($data->email) && isset($data->password) && isset($data->passwordRepeat)) {
                $username = htmlentities($data->name);
                $email = htmlentities($data->email);
                $password = htmlentities($data->password);
                $password_repeat = htmlentities($data->passwordRepeat);
                $users_manager = new UsersManager();
                $errors = $users_manager->register($username, $email, $password, $password_repeat);  

                return json_encode($errors);
            }

            return $this->render('register.html.twig');
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
            header('Location: /login');
            exit();
        } else {
            $manager = new UsersManager;
            if (isset($_POST['change-pic-btn'])) {
                $type = $_FILES['pic']['type'];
                $size = $_FILES['pic']['size'];
                $name = $_FILES['pic']['name'];
                $tmp_name = $_FILES['pic']['tmp_name'];
                $errors = [];
                if($type !== 'image/png' && $type !== 'image/jpg' && $type !== 'image/jpeg') {
                    $errors['type'] = 'You can only upload png/jpg/jpeg files';
                } else {
                    $manager = new UsersManager;
                    $manager->changePic($name, $tmp_name, $type, $size);
                }
            }
            $_SESSION['followings'] = $manager->getUserFollowings($_SESSION['id']);
            $_SESSION['followers'] = $manager->getUserFollowers($_SESSION['id']);
            $twtts_manager = new TwttsManager;
            $my_twtts = $twtts_manager->getUserTwtts($_SESSION['id']);
            $data = [
                'user' => $_SESSION,
                'twtts'=> $my_twtts,
            ];
        }
        return $this->render('profile.html.twig', $data);
    }

    public function followAction() {
        $manager = new UsersManager;
        $manager->follow($_POST['follower'], $_POST['followed']);
        $response = new \stdClass;
        $response->text = 'Followed';
        $response->target = '/unfollow';
        $response->followers = 'Followers: '. $manager->getUserFollowers($_POST['followed']);
        $response->followings = 'Following: ' . $manager->getUserFollowings($_POST['followed']);
        return json_encode($response);
    }

    public function unfollowAction() {
        $manager = new UsersManager;
        $manager->unfollow($_POST['follower'], $_POST['followed']);
        $response = new \stdClass;
        $response->text = 'Follow';
        $response->target = '/follow';
        $response->followers = 'Followers: '. $manager->getUserFollowers($_POST['followed']);
        $response->followings = 'Following: ' . $manager->getUserFollowings($_POST['followed']);
        return json_encode($response);
    }

    public function userProfileAction()
    {
        $regex = '/profile\/([a-zA-Z]+)/';
        preg_match($regex, $_SERVER['REQUEST_URI'], $matches);
        $username = $matches[1];
        $manager = new UsersManager;
        $userData = $manager->getUserInfo($username);
        if (isset($_SESSION['id']) && $userData['id'] == $_SESSION['id'])
        {
            return header('Location: /profile');
        }
        if (isset($_SESSION['name']))
        {
            $userData['is_followed_by'] = $manager->isAlreadyFollowed($_SESSION['id'], $userData['id']) ? true : false;
        }
        $userData['followings'] = $manager->getUserFollowings($userData['id']);
        $userData['followers'] = $manager->getUserFollowers($userData['id']);
        $twtt_manager = new TwttsManager();
        $userTwtts = $twtt_manager->getUserTwtts($userData['id']);
        $data = [
            'user'        => $_SESSION,
            'userProfile' => $userData,
            'twtts'       => $userTwtts
        ];
        return $this->render('userprofile.html.twig', $data);
    }
}
