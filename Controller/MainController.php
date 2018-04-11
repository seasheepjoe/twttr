<?php

namespace Controller;

use Cool\BaseController;

class MainController extends BaseController
{
    public function homeAction()
    {
        return $this->render('home.html.twig');
    }
}
