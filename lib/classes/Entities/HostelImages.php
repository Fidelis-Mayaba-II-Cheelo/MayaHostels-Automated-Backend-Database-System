<?php

class HostelImages extends Entity{
    //primary key
    var $mh_hostel_images_id;

    //other columns
    var $mh_hostel_image;
    var $mh_hostel_id;

    //References to Entities
    var ?Hostels $hostels;

    //mappings
    var array $__mapping = [
        'mh_hostel_images_id' => 'maya_hostels_images_id',
        'mh_hostel_image' => 'hostel_image',
        'mh_hostel_id' => 'maya_hostels_hostel_id'
    ];

    //relationships
    var array $__relationships = [
        'hostels' => [
            'field' => 'mh_hostel_id',
            'table' => 'hostels'
        ]
    ];
}