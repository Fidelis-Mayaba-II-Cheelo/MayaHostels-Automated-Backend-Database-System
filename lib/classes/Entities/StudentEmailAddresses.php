<?php

class StudentEmailAddresses extends Entity{
    //primary keys
    var $mh_student_id;
    var $mh_email_address;
    
    //other columns
    var $mh_email_type;

    //entities
    var ?Students $students;

    //mappings
    var array $__mapping = [
        'mh_student_id' => 'maya_hostels_student_id',
        'mh_email_address' => 'email_address',
        'mh_email_type' => 'email_type',
    ];

    //relationships
    var array $__relationships = [
        'students' => [
            'field' => 'mh_student_id',
            'table' => 'students'
        ]
    ];
}