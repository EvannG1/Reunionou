<?php

require_once '../src/vendor/autoload.php';

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use ReunionouAPI\Controllers\Controller as API;

$settings       = require_once '../config/settings.php';
$dependencies   = require_once '../config/dependencies.php';
$errors         = require_once '../config/errors.php';
 
$config = parse_ini_file($settings['settings']['dbfile']);
$db = new \Illuminate\Database\Capsule\Manager();
$db->addConnection($config);
$db->setAsGlobal();
$db->bootEloquent();

$c = new \Slim\Container(array_merge($settings, $dependencies, $errors));
$app = new \Slim\App($c);

$app->add(ReunionouAPI\Middlewares\Cors::class . ':checkAndAddCorsHeaders');

$app->options('/{routes:.+}', function(Request $rq, Response $rs, array $args) {
    return $rs;
});

$app->get('/events', function(Request $req, Response $resp) {
    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(API::getEvents());
    return $response;
});

$app->get('/event/{id}', function(Request $req, Response $resp, $args) {
    $id = $args['id'];
    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(API::getEvent($id));
    return $response;
});

$app->get('/comments', function(Request $req, Response $resp) {
    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(API::getComments());
    return $response;
});

$app->get('/comment/{id}', function(Request $req, Response $resp, $args) {
    $id = $args['id'];
    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(API::getComment($id));
    return $response;
});

$app->get('/shared', function(Request $req, Response $resp) {
    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(API::getShared());
    return $response;
});

$app->get('/shared/{id}', function(Request $req, Response $resp, $args) {
    $id = $args['id'];
    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(API::getSharedEvent($id));
    return $response;
});

$app->run();