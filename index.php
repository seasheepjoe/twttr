<?php

require_once('vendor/autoload.php');

use Symfony\Component\Yaml\Yaml;
use Routing\Router;

$config = Yaml::parseFile('config/config.yml');
$params = Yaml::parseFile('config/parameters.yml');

session_start();

$loader = new Twig_Loader_Filesystem('views');
$twig = new Twig_Environment($loader, array(
    //'cache' => 'cache/twig',
    'cache' => false,
));

$request = substr($_SERVER['REQUEST_URI'], 1);
$request = explode('?', $request)[0];
if (substr($request, -1) == '/')
{
    $request = substr($request, 0, -1);
}

if ($request == '') {
    $request = 'home';
}

$router = new Router();

$response = $router->execute($request);
echo $response;