<?php

require_once('vendor/autoload.php');

use Symfony\Component\Yaml\Yaml;
use Routing\Router;

$config = Yaml::parseFile('config/config.yml');
$params = Yaml::parseFile('config/parameters.yml');

$loader = new Twig_Loader_Filesystem('views');
$twig = new Twig_Environment($loader, array(
    //'cache' => 'cache/twig',
    'cache' => false,
));

$request = empty($_GET['action']) ? $config['homepage_route'] : $_GET['action'];
$router = new Router();
$response = $router->execute($request);
echo $response;
