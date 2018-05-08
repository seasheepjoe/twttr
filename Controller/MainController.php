<?php

namespace Controller;

use Cool\BaseController;
use Model\UsersManager;
use Model\TwttsManager;

class MainController extends BaseController
{
    public function homeAction()
    {
        $manager = new TwttsManager;
        $twtts = $manager->getTwtts();
        // die(var_dump('<pre>', $twtts));
        $data = [
            'twtts' => $twtts,
            'user' => $_SESSION,
        ];

        return $this->render('home.html.twig', $data);
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
