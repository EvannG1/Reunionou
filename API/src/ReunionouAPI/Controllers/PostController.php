<?php
namespace ReunionouAPI\Controllers;

use ReunionouAPI\Controllers\AuthController;
use ReunionouAPI\Models\Event;
use ReunionouAPI\Models\User;
use ReunionouAPI\Models\Location;

class PostController {

    public static $message = 
    [
        "empty"     =>  "Un ou plusieurs champs sont manquants !",
        "exist"     =>  "La ressource spécifiée n'existe pas !",
        "incorrect" =>  "Email ou mot de passe incorrect !"
    ];

    private static function success(){
        return json_encode([
            'post'      => true
        ]);
    }

    private static function error(string $message){
        return json_encode([
            'post'      => false,
            'message'   => $message
        ]);
    }

    private static function generateToken(){
        return bin2hex(random_bytes(16));
    }

    public static function signin($email, $password) {
        $user = User::where('email', $email)->first();
        if(!is_null($user)) {
            if(AuthController::verifyPassword($password, $user->password)) {
                $response = [
                    'fullname'  =>  $user->fullname,
                    'email'     =>  $user->email,
                    'token'     =>  $user->token
                ];
                return json_encode($response);
            } else {
                return self::error(self::$message['incorrect']);
            }
        } else {
            return self::error(self::$message['incorrect']);
        }
    }

    public static function postEvent($title, $description, $date, $location, $x, $y) {
        if(empty($title) || empty($description) || empty($date) || empty($location) || empty($x) || empty ($y)) {
            return self::error(self::$message['empty']);
        } else {
            Location::insert(['name' => $location, 'x' => $x, 'y' => $y]);
            $location_lastInsertedId = Location::latest('id')->first()->id;

            $token = self::generateToken();
            Event::insert(['title' => $title, 'description' => $description, 'date' => $date, 'location_id' => $location_lastInsertedId, 'user_id' => $_SESSION['id'], 'token' => $token]);

            return self::success();
        }
    }

    public static function editEvent($id, $title, $description, $date, $location, $x, $y) {
        if(empty($title) || empty($description) || empty($date) || empty($location) || empty($x) || empty ($y)) {
            return self::error(self::$message['empty']);
        } else {
            $exist = Event::where('id', $id)->count();
            if(!$exist) {
                return self::error(self::$message['exist']);
            } else {
                $location_id = Event::where('id', $id)->first()->location_id;
                Location::where('id', $location_id)->update(['name' => $location, 'x' => $x, 'y' => $y]);
    
                Event::where('id', $id)->update(['title' => $title, 'description' => $description, 'date' => $date]);
    
                return self::success();
            }
        }
    }

}