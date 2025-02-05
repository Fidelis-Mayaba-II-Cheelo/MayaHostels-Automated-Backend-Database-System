<?php

class StudentPhoneNumbers extends Entity{
    //primary key
    var $mh_student_id;
    var $mh_phone_number;

    //other columns
    var $mh_phone_number_type;

    //reference to entities
    var ?Students $students;

    //mappings
    var array $__mapping = [
        'mh_student_id' => 'maya_hostels_student_id',
        'mh_phone_number' => 'phone_number',
        'mh_phone_number_type' => 'phone_number_type',
    ];

    //relationships
    var array $__relationships = [
        'students' => [
            'field' => 'mh_student_id',
            'table' => 'students'
        ]
    ];
}