<?php

class AdminEmailAddresses extends Entity{
    //primary keys
    var $mh_admin_id;
    var $mh_admin_email_address;

    //other columns
    var $mh_admin_email_type;

    //References to Entites
    var ?Admin $admin;

    //mappings
    var array $__mapping = [
        'mh_admin_id' => 'maya_hostels_admin_id',
        'mh_admin_email_address' => 'email_address',
        'mh_admin_email_type' => 'email_type',
    ];

    //relationships
    var array $__relationships = [
        'admin' => [
            'field' => 'mh_admin_id',
            'table' => 'admin'
        ]
    ];
}