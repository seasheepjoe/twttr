<?php

namespace Controller;

use Cool\BaseController;
use Model\UsersManager;
use Model\TwttsManager;

class MainController extends BaseController
{
    public function homeAction()
    {
        if (isset($_SESSION['id']))
        {
            $manager = new TwttsManager;
            $twtts = $manager->getTwtts();
            $data = [
                'twtts' => $twtts,
                'user' => $_SESSION,
            ];

            if (isset($_POST['last_date'])) {
                $manager = new TwttsManager;
                $newTwtts = $manager->getNewTwtts($_POST['last_date']);

                $data = [
                    'twtts' => $newTwtts,
                    'user'  => $_SESSION,
                ];
                
                return json_encode(['html' => $this->render('twtt.html.twig', $data)]);
            }

            return $this->render('home.html.twig', $data);
        } else {
            return header('Location: /login');
        }
    }

    public function error404Action()
    {
        $data = [
            'user' => $_SESSION,
            'request' => substr($_SERVER['REQUEST_URI'], 1)
        ];
        
        return $this->render('404.html.twig', $data);
    }
}
