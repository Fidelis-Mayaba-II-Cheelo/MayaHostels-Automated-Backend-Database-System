<?php

class Complaints extends Entity{
    //primary key
    var $mh_complaints_id;
    //other columns
    var $mh_student_complaint_message;
    var $mh_admin_complaint_resolution_message;
    var $mh_student_issue_date;
    var $mh_admin_resolution_date;
    var $mh_student_complaint_status;
    var $mh_admin_complaint_resolution_status;
    var $mh_admin_id;
    var $mh_student_id;

    //References to entities
    var ?Admin $admin;
    var ?Students $students;

    //mappings
    var array $__mapping = [
        'mh_complaints_id' => 'maya_hostels_complaints_id',
        'mh_student_complaint_message' => 'student_complaint_message',
        'mh_admin_complaint_resolution_status' => 'admin_complaint_resolution_status',
        'mh_student_issue_date' => 'student_issue_date',
        'mh_admin_resolution_date' => 'admin_resolution_date',
        'mh_student_complaint_status' => 'student_complaint_status',
        'mh_admin_complaint_resolution_status' => 'admin_complaint_resolution_status',
        'mh_admin_id' => 'maya_hostels_admin_id',
        'mh_student_id' => 'maya_hostels_student_id'
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