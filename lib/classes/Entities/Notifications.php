<?php

class Notifications extends Entity{
    //primary key
    var $mh_notifications_id;

    //other columns
    var $mh_notification_message;
    var $mh_notification_status;
    var $mh_date_sent;
    var $mh_admin_id;
    var $mh_student_id;

    //Reference to entities
    var ?Admin $admin;
    var ?Students $students;

    //mappings
    var array $__mapping = [
        'mh_notifications_id' => 'maya_hostels_notifications_id',
        'mh_notification_message' => 'notification_message',
        'mh_notification_status' => 'notification_status',
        'mh_date_sent' => 'date_sent',
        'mh_admin_id' => 'maya_hostels_admin_id',
        'mh_student_id' => 'maya_hostels_student_id',
    ];

    //relationships
    var array $__relationships = [
        'admin' => [
            'field' => 'mh_admin_id',
            'table' => 'admin'
        ],
        'students' => [
            'field' => 'mh_student_id',
            'table' => 'students'
        ]
    ];
}