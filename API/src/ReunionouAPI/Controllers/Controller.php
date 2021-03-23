<?php
namespace ReunionouAPI\Controllers;

use ReunionouAPI\Models\Event;

class Controller {

    public static function getEvents() {
        $events = Event::select()->with('locations')->get();
        $events->makeHidden(['location_id']);
        return json_encode($events);
    }

    public static function getEvent($id) {
        $events = Event::where('id', $id)->with('locations')->get();
        $events->makeHidden(['location_id']);
        return json_encode($events);
    }

}