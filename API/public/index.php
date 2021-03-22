<?php

require_once '../src/vendor/autoload.php' ;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


$settings       = require_once '../config/settings.php' ;
$dependencies   = require_once '../config/dependencies.php';
$errors         = require_once '../config/errors.php';
 
// $config = parse_ini_file($settings['settings']['dbfile']);
// $db = new \Illuminate\Database\Capsule\Manager();
// $db->addConnection($config);
// $db->setAsGlobal();
// $db->bootEloquent();

$c = new \Slim\Container(array_merge($settings, $dependencies, $errors));
$app = new \Slim\App($c);

$app->add(ReunionouAPI\Middlewares\Cors::class . ':checkAndAddCorsHeaders');

$app->options('/{routes:.+}', function(Request $rq, Response $rs, array $args) {
    return $rs;
});

$app->get('/hello', function(Request $req, Response $resp, $args) {
    $resp->getBody()->write('salut bastien t es un peu con sur les bord non ? spoiler va');
    return $resp;
});

$app->run();