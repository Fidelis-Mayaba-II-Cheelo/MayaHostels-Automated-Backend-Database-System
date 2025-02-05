<?php

class Rooms extends Entity{
    //primary key
    var $mh_rooms_id;

    //other columns
    var $mh_room_number;
    var $mh_room_capacity;
    var $mh_hostel_id;

    //reference to entities
    var ?Hostels $hostels;

    //mappings
    var array $__mapping = [
        'mh_rooms_id' => 'maya_hostels_room_id',
        'mh_room_number' => 'room_number',
        'mh_room_capacity' => 'room_capacity',
        'mh_hostel_id' => 'maya_hostels_hostel_id',
    ];

    //relationships
    var array $__relationships = [
        'hostels' => [
            'field' => 'mh_hostel_id',
            'table' => 'hostels'
        ]
    ];
}