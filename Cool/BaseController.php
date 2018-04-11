<?php

namespace Cool;

class BaseController
{
    protected function render($view, $data = [])
    {
        global $twig;
        $template = $twig->load($view);
        $response = $template->render($data);

        return $response;
    }
    
    protected function redirect($url)
    {
        header('Location: '.$url);
        exit();
    }
    
    protected function redirectToRoute($route)
    {
        $this->redirect('?action='.$route);
    }
}
