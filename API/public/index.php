<?php

require_once '../src/vendor/autoload.php';

session_start();

use Slim\Http\Response as Response;
use Slim\Http\Request as Request;
use ReunionouAPI\Controllers\GetController as GetAPI;
use ReunionouAPI\Controllers\PostController as PostAPI;
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

// $app->add(ReunionouAPI\Middlewares\Cors::class . ':checkAndAddCorsHeaders');

$app->add(function ($req, $res, $next) {
    $response = $next($req, $res);
    return $response
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
});

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

    // Route (POST) : permet de poster un commentaire sur un article depuis son ID
    $this->post('/comment/{id}', function(Request $req, Response $resp, $args) {
        $id = $args['id'];
        $content = $req->getParam('content');
        $event_id = $req->getParam('event_id');
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(PostAPI::postComment($id, $content, $event_id));
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

    // Route (POST) : permet de créer un évènement
    $this->post('/create/event', function(Request $req, Response $resp) {
        $title = $req->getParam('title');
        $description = $req->getParam('description');
        $date = $req->getParam('date');
        $location = $req->getParam('location');
        $x = $req->getParam('x');
        $y = $req->getParam('y');

        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(PostAPI::postEvent($title, $description, $date, $location, $x, $y));
        return $response;
    });

    // Route (POST) : permet de modifier un évènement
    $this->post('/edit/event/{id}', function(Request $req, Response $resp, $args) {
        $id = $args['id'];
        $title = $req->getParam('title');
        $description = $req->getParam('description');
        $date = $req->getParam('date');
        $location = $req->getParam('location');
        $x = $req->getParam('x');
        $y = $req->getParam('y');

        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(PostAPI::editEvent($id, $title, $description, $date, $location, $x, $y));
        return $response;
    });

    // Route (POST) : permet de modifier un évènement
    $this->post('/delete/event/{id}', function(Request $req, Response $resp, $args) {
        $id = $args['id'];
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(PostAPI::deleteEvent($id));
        return $response;
    });

    // Route (POST) : permet de modifier son profil
    $this->post('/edit/profile', function(Request $req, Response $resp) {
        $fullname = $req->getParam('fullname');
        $email = $req->getParam('email');
        $password = $req->getParam('password');
        $response = $resp->withHeader('Content-Type', 'application/json');
        $response->getBody()->write(PostAPI::editProfile($fullname, $email, $password));
        return $response;
    });
})->add(new TokenMiddleware($c));

// Route (POST) : permet la connexion
$app->post('/signin', function(Request $req, Response $resp) {
    $email = $req->getParam('email');
    $password = $req->getParam('password');

    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(PostAPI::signin($email, $password));
    return $response;
});

// Route (POST) : permet l'inscription
$app->post('/signup', function(Request $req, Response $resp) {
    $fullname = $req->getParam('fullname');
    $email = $req->getParam('email');
    $password = $req->getParam('password');

    $response = $resp->withHeader('Content-Type', 'application/json');
    $response->getBody()->write(PostAPI::signup($fullname, $email, $password));
    return $response;
});

$app->run();