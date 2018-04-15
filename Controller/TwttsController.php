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
}
