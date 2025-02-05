<?php

class Students extends Entity{
    //primary key
    var $mh_student_id;

    //other columns
    var $mh_student_name;
    var $mh_student_number;
    var $mh_national_registration_number;
    var $mh_program_of_study;
    var $mh_year_of_study;
    var $mh_date_of_birth;
    var $mh_profile_picture;
    var $mh_gender;
    var $mh_accommodation_status;
    var $mh_hostel_id;
    var $mh_room_id;
    var $mh_bedspaces_id;

    //reference to entities
    var ?Hostels $hostels;
    var ?Rooms $rooms;
    var ?Bedspaces $bedspaces;

    //mappings
    var array $__mapping = [
        'mh_student_id' => 'maya_hostels_student_id',
        'mh_student_name' => 'student_name',
        'mh_student_number' => 'student_number',
        'mh_national_registration_number' => 'national_registration_number',
        'mh_program_of_study' => 'program_of_study',
        'mh_year_of_study' => 'year_of_study',
        'mh_date_of_birth' => 'date_of_birth',
        'mh_profile_picture' => 'profile_picture',
        'mh_gender' => 'gender',
        'mh_accommodation_status' => 'accommodation_status',
        'mh_hostel_id' => 'maya_hostels_hostel_id',
        'mh_room_id' => 'maya_hostels_room_id',
        'mh_bedspaces_id' => 'maya_hostels_bedspaces_id'
    ];
}