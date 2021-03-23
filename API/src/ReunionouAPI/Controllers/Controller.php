<?php
namespace ReunionouAPI\Controllers;

use ReunionouAPI\Models\Event;
use ReunionouAPI\Models\Comment;
use ReunionouAPI\Models\Shared;

class Controller {

    public static function getEvents() {
        $events = Event::select()->with('location')->get();
        $events->makeHidden(['location_id']);
        return json_encode($events);
    }

    public static function getEvent($id) {
        $event = Event::where('id', $id)->with('location')->get();
        $event->makeHidden(['location_id']);
        return json_encode($event);
    }

    public static function getComments() {
        $comments = Comment::select()->with('user')->get();
        $comments->makeHidden(['user_id']);
        return json_encode($comments);
    }

    public static function getComment($id) {
        $comment = Comment::where('id', $id)->with('user')->get();
        $comment->makeHidden(['user_id']);
        return json_encode($comment);
    }

    public static function getShared() {
        $shared = Shared::select()->with('event')->with('user')->get();
        $shared->makeHidden(['event_id', 'user_id']);
        return json_encode($shared);
    }

    public static function getSharedEvent($id) {
        $shared = Shared::where('event_id', $id)->with('user')->get();
        $shared->makeHidden(['user_id']);
        return json_encode($shared);
    }

}