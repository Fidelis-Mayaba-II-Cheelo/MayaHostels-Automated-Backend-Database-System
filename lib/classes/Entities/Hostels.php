<?php

class Hostels extends Entity{
    //primary key
    var $mh_hostel_id;
    
    //other columns
    var $mh_hostel_name;
    var $mh_number_of_rooms;
    var $mh_hostel_status;
    var $mh_hostel_type;
    var $mh_hostel_capacity;
    var $mh_number_of_bedspaces_per_room;
    var $mh_hostel_accommodation_price_per_semester;
    var $mh_hostel_accommodation_price_per_month;
    var $mh_admin_id;

    //References to Entities
    var ?Admin $admin;

    //mappings
    var array $__mapping = [
        'mh_hostel_id' => 'maya_hostels_hostel_id',
        'mh_hostel_name' => 'hostel_name',
        'mh_number_of_rooms' => 'number_of_rooms',
        'mh_hostel_status' => 'hostel_status',
        'mh_hostel_type' => 'hostel_type',
        'mh_hostel_capacity' => 'hostel_capacity',
        'mh_number_of_bedspaces_per_room' => 'number_of_bedspaces_per_room',
        'mh_hostel_accommodation_price_per_semester' => 'hostel_accommodation_price_per_semester',
        'mh_hostel_accommodation_price_per_month' => 'hostel_accommodation_price_per_month',
        'mh_admin_id' => 'maya_hostels_admin_id'
    ];

    //relationships
    var array $__relationships = [
        'admin' => [
            'field' => 'mh_admin_id',
            'table' => 'admin'
        ]
    ];
}