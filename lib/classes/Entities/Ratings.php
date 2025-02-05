<?php

class Ratings extends Entity{
    //primary key
    var $mh_ratings_id;
    //other columns
    var $mh_student_rating_message;
    var $mh_student_scale_rating;
    var $mh_student_improvement_suggestions;
    var $mh_rating_status;
    var $mh_date_added;
    var $mh_admin_id;
    var $mh_student_id;

    //references to entities
    var ?Admin $admin;
    var ?Students $students;

    //mappings
    var array $__mapping = [
        'mh_ratings_id' => 'maya_hostels_ratings_id',
        'mh_student_rating_message' => 'student_rating_message',
        'mh_student_scale_rating' => 'student_scale_rating',
        'mh_student_improvement_suggestions' => 'student_improvement_suggestions',
        'mh_rating_status' => 'rating_status',
        'mh_date_added' => 'date_added',
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