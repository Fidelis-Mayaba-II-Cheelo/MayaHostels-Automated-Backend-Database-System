<?php

class RoomsDao extends Dao{
    private $roomsDao;
    protected $table = 'rooms';
    protected $primaryKeyField = 'maya_hostels_room_id';

    function init(){
        $this->entity = new Rooms();
    }
}