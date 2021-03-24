<?php
namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Controllers\Auth\AuthController;
use App\Models\Admin;
use App\Models\User;

class PagesPostController extends Controller {

    public function login(Request $request, Response $response) {
        $email = htmlspecialchars(trim($request->getParam('email_address')));
        $password = htmlspecialchars(trim($request->getParam('password')));
        
        if(empty($email) || empty($password)) {
            $this->flash('Un ou plusieurs champs sont vide(s) !', 'error');
        } else {
            if(!AuthController::login($email, $password)) {
                $this->flash('Adresse email ou mot de passe incorrect !', 'error');
            } else {
                return $this->redirect($response, 'home');
            }
        }
        return $this->redirect($response, 'login');
    }

    public function profile(Request $request, Response $response) {
        $currentPassword = htmlspecialchars(trim($request->getParam('currentPassword')));
        $newPassword = htmlspecialchars(trim($request->getParam('newPassword')));

        if(empty($currentPassword) || empty($newPassword)) {
            $this->flash("Un ou plusieurs champs sont vides !", 'error');
        } else {
            $db_password = Admin::select('password')->where('id', $_SESSION['id'])->first();

            if(AuthController::verifyPassword($currentPassword, $db_password->password)) {
                $hashedPassword = AuthController::hashPassword($newPassword);
                Admin::where('id', $_SESSION['id'])->update(['password' => $hashedPassword]);
                $this->flash("Le mot de passe a bien été sauvegardé !");
            } else {
                $this->flash("Mot de passe actuel incorrect !", 'error');
            }
        }
        return $this->redirect($response, 'profile');
    }

    public function createUser(Request $request, Response $response) {
        $firstname_user = htmlspecialchars(trim($request->getParam('name_user')));
        $lastname_user = htmlspecialchars(trim($request->getParam('forname_user')));
        $mail_user = htmlspecialchars(trim($request->getParam('mail_user')));
        $password_user = htmlspecialchars(trim($request->getParam('mdp_user')));
        $rank_user = htmlspecialchars(trim($request->getParam('rank_user')));

        if(!filter_var($mail_user, FILTER_VALIDATE_EMAIL)) {
            $this->flash('Cette adresse email est invalide !', 'error');
        } else {
            if(empty($firstname_user || $lastname_user || $mail_user || $password_user || $rank_user)) {
                $this->flash('Veuillez renseigner tous les champs !', 'error');
            } else {
                $exist = User::where('email', '=', $mail_user)->count();
                if($exist) {
                    $this->flash('Cette adresse e-mail est déjà utilisée !', 'error');
                } else {
                    $password_hash = AuthController::hashPassword($password_user);
                    User::insert(['nom' => $firstname_user, 'prenom' => $lastname_user, 'email' => $mail_user, 'mdp' => $password_hash, 'is_superadmin' => $rank_user]);
                    $this->flash("L'utilisateur a été créé avec succès !");
                }
            }
        }        
        return $this->redirect($response, 'createUser');
    }

    public function userDelete(Request $request, Response $response) {
        $id = $request->getParam('id');
        $exist = User::where('id', '=', $id)->count();
        
        if(!$exist) {
            return "L'utilisateur que vous essayez de supprimer n'existe pas !";
        } else {
            User::where('id', '=', $id)->delete();
            return "success";
        }
    }

    public function userUpdate(Request $request, Response $response) {
        $id = $request->getParam('id');
        $firstname = htmlspecialchars(trim($request->getParam('newNom')));
        $lastname = htmlspecialchars(trim($request->getParam('newPrenom')));
        $email = htmlspecialchars(trim($request->getParam('newEmail')));
        $rank = htmlspecialchars(trim($request->getParam('newRank')));
    
        $exist = User::where('id', '=', $id)->count();
    


        if(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $this->flash('Cette adresse email est invalide !', 'error');
        } else {
            if(!$exist) {
                return "L'utilisateur que vous essayez de modifier n'existe pas !";
            } else {
                User::where('id', '=', $id)->update(['nom' => $firstname, 'prenom' => $lastname, 'email' => $email, 'is_superadmin' => $rank]);
                return "success";
            }
        } 

    }

}