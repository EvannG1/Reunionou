<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Admin extends Model {

    protected $table = 'admins';
    protected $primaryKey = 'id';
    public $timestamps = false;

}