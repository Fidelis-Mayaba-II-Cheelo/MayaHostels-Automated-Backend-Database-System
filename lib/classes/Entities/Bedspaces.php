<?php

class Bedspaces extends Entity {
    //primary key
    var $mh_bedspaces_id;

    //other columns
    var $mh_is_occupied;
    var $mh_bedspace_number;
    var $mh_room_id;

    //References to entities
    var ?Rooms $rooms;

    //mappings
    var array $__mapping = [
        'mh_bedspaces_id' => 'maya_hostels_bedspaces_id',
        'mh_is_occupied' => 'is_occupied',
        'mh_bedspace_number' => 'bedspace_number',
        'mh_room_id' => 'maya_hostels_room_id',
    ];

    //relationships
    var array $__relationships = [
        'rooms' => [
            'field' => 'mh_room_id',
            'table' => 'rooms'
        ]
    ];
}