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

        $data = json_decode(file_get_contents('php://input'));
        if (isset($data->content)) {
            $manager = new TwttsManager;
            $manager->setTwtt($_SESSION['id'], htmlentities($data->content));
            $last_twtt = $manager->getUserLastTwtt($_SESSION['id']);

            $data = [
                'last_twtt' => $last_twtt,
                'user'  => $_SESSION,
            ];
            
            return json_encode([
                'status' => true,
                'html' => $this->render('twtt.html.twig', $data),
                ]);
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
