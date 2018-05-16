<?php

namespace Controller;

use Cool\BaseController;
use Model\TwttsManager;

class TwttsController extends BaseController
{
    public function newTwttAction()
    {
        if (!isset($_SESSION['name'])) {
            header('Location: /login');
            exit();
        }
        if (!empty($_POST['twtt-content'])) {
            $manager = new TwttsManager;
            $manager->setTwtt($_SESSION['id'], $_POST['twtt-content']);
            header('Location: /home');
            exit();
        }
    }

    public function rtwttAction ()
    {   
        if (isset($_GET['id']) && $id = intval($_GET['id']))
        {
            $manager = new TwttsManager;
            return $manager->setReaction('rtwtt', $_SESSION['id'], $_GET['id']);
        }
    }

    public function favAction ()
    {
        if (isset($_GET['id']) && $id = intval($_GET['id']))
        {
            $manager = new TwttsManager;
            return $manager->setReaction('favs', $_SESSION['id'], $_GET['id']);
        }
    }
}
