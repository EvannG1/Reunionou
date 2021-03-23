<?php
namespace ReunionouAPI\Models;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    
    protected $table = 'events';
    protected $primaryKey = 'id';
    public $timestamps = false;

    public function locations(){
        return $this->belongsTo('ReunionouAPI\Models\Location', 'location_id');
    }

}