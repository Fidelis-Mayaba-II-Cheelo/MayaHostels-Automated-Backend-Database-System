<?php

class StudentGuardianPhoneNumbers extends Entity{
    //primary key
    var $mh_student_id;
    var $mh_guardian_phone_number;

    //other columns
    var $mh_guardian_phone_number_type;

    //reference to entities
    var ?Students $students;

    //mappings
    var array $__mapping = [
        'mh_student_id' => 'maya_hostels_student_id',
        'mh_guardian_phone_number' => 'guardian_phone_number',
        'mh_guardian_phone_number_type' => 'guardian_phone_number_type',
    ];

    //relationships
    var array $__relationships = [
        'students' => [
            'field' => 'mh_student_id',
            'table' => 'students'
        ]
    ];
}