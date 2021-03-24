<?php

require_once '../src/vendor/autoload.php';

session_start();

use \Psr\Http\Message\ResponseInterface as Response;
use \Psr\Http\Message\ServerRequestInterface as Request;
use ReunionouAPI\Controllers\GetController as GetAPI;
use ReunionouAPI\Middlewares\TokenMiddleware;

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

$app->group('', function() {

    // Route (GET) : récupère la liste de tous les évènements
    $this->get('/events', function(Request $req, Response $resp) {
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(GetAPI::getEvents());
        return $response;
    });
    
    // Route (GET) : récupère un évènement depuis son ID
    $this->get('/event/{id}', function(Request $req, Response $resp, $args) {
        $id = $args['id'];
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(GetAPI::getEvent($id));
        return $response;
    });
    
    // Route (GET) : récupère la liste de tous les commentaires
    $this->get('/comments', function(Request $req, Response $resp) {
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(GetAPI::getComments());
        return $response;
    });
    
    // Route (GET) : récupère la liste de tous les commentaires associées à un évènement depuis son ID
    $this->get('/comments/{id}', function(Request $req, Response $resp, $args) {
        $id = $args['id'];
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(GetAPI::getComment($id));
        return $response;
    });
    
    // Route (GET) : récupère la liste de tous les partages
    $this->get('/shared', function(Request $req, Response $resp) {
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(GetAPI::getShared());
        return $response;
    });
    
    // Route (GET) : récupère la liste de tous les partages associés à un évènement depuis son ID
    $this->get('/shared/{id}', function(Request $req, Response $resp, $args) {
        $id = $args['id'];
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(GetAPI::getSharedEvent($id));
        return $response;
    });
})->add(new TokenMiddleware($c));

$app->run();