<?php
namespace ReunionouAPI\Controllers;

use ReunionouAPI\Controllers\AuthController;
use ReunionouAPI\Models\Event;
use ReunionouAPI\Models\User;
use ReunionouAPI\Models\Location;

class PostController {

    private static function success(){
        return json_encode([
            'post'      => true
        ]);
    }

    private static function error(){
        return json_encode([
            'post'      => false,
            'message'   => "Un ou plusieurs champs sont manquants !"
        ]);
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
            }
        }
    }

    public static function postEvent($title, $description, $date, $location, $x, $y) {
        if(empty($title) || empty($description) || empty($date) || empty($location) || empty($x) || empty ($y)) {
            return self::error();
        } else {
            Location::insert(['name' => $location, 'x' => $x, 'y' => $y]);
            $location_id = Location::latest('id')->first()->id;

            Event::insert(['title' => $title, 'description' => $description, 'date' => $date, 'location_id' => $location_id, 'user_id' => $_SESSION['id'], 'token' => 'sss']);

            return self::success();
        }
    }

}