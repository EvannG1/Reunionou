<?php
namespace ReunionouAPI\Controllers;

use ReunionouAPI\Models\Event;
use ReunionouAPI\Models\Comment;
use ReunionouAPI\Models\Shared;

class GetController {

    public static function getEvents() {
        $events = Event::where('user_id', $_SESSION['id'])->with('location')->with('author')->get();
        $events->makeHidden(['location_id', 'user_id']);

        $shared = Shared::where('user_id', $_SESSION['id'])->with('event')->get();
        $shared->makeHidden(['id', 'event_id', 'user_id']);

        return json_encode(['owned' => $events, 'shared' => $shared]);
    }

    public static function getEvent($id) {
        $owned = Event::where(['id' => $id, 'user_id' => $_SESSION['id']])->count();
        $shared = Shared::where(['event_id' => $id, 'user_id' => $_SESSION['id']])->count();

        if($owned || $shared) {
            $event = Event::where('id', $id)->with('location')->with('author')->get();
            $event->makeHidden(['location_id', 'user_id']);
            return json_encode($event);
        } else {
            return json_encode(['error' => 'permissions denied']);
        }
    }

    public static function getComments() {
        $comments = Comment::where('user_id', $_SESSION['id'])->with('user')->get();
        $comments->makeHidden(['user_id']);

        $shared = Shared::where('user_id', $_SESSION['id'])->with('comments')->with('user')->get();
        $shared->makeHidden(['id', 'event_id', 'user_id']);

        return json_encode(['owned' => $comments, 'shared' => $shared]);
    }

    public static function getComment($id) {
        $owned = Event::where(['id' => $id, 'user_id' => $_SESSION['id']])->count();
        $shared = Shared::where(['event_id' => $id, 'user_id' => $_SESSION['id']])->count();

        if($owned || $shared) {
            $comment = Comment::where('event_id', $id)->with('user')->get();
            $comment->makeHidden(['user_id']);
            return json_encode($comment);
        } else {
            return json_encode(['error' => 'permissions denied']);
        }        
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