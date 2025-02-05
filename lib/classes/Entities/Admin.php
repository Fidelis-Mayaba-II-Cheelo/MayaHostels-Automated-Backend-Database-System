<?php

class Admin extends Entity{
    //primary key
    var $mh_admin_id;

    //other columns
    var $mh_username;

    //mappings
    var array $__mapping = [
        'mh_admin_id' => 'maya_hostels_admin_id'
    ];
}