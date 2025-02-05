<?php

class Accounts extends Entity{

    //primary key
    var $mh_accounts_id;

    //Other columns
    var $mh_account_type;
    var $mh_account_password;
    var $mh_account_status;
    var $mh_hash_algorithm;

    //Foreign keys
    var $mh_admin_id;
    var $mh_student_id;

    //Entities that have a relationship with the accounts table in the db
    //(References to related Admin and Student entities.)
    var ?Admin $admin;
    var ?Student $student;

    //Mapping our properties to the actual database fields
    var array $__mapping = [
        "mh_accounts_id" => "maya_hostels_accounts_id",
        "mh_account_type" => "account_type",
        "mh_account_password" => "account_password",
        "mh_account_status" => "account_status",
        "mh_hash_algorithm" => "hash_algorithm",
        "mh_admin_id" => "maya_hostels_admin_id",
        "mh_student_id" => "maya_hostels_student_id",
    ];

    //Describing the relationships existing in our accounts table in the db
    var array $__relationships = [
        "admin" => [
            "field" => "mh_admin_id",
            "table" => "admin",
        ],
        "student" => [
            "field" => "mh_student_id",
            "table" => "student",
        ]
    ];
}