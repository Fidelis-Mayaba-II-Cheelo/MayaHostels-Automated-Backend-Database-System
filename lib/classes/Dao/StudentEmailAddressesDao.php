<?php

class StudentEmailAddressesDao extends Dao {
    private $studentEmailAddressesDao;
    protected $table = 'student_email_addresses';
    protected $primaryKeyField = ['maya_hostels_student_id', 'email_address'];

    function init(){
        $this->entity = new StudentEmailAddresses();
    }
}