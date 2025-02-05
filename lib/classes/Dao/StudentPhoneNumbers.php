<?php

class StudentPhoneNumbersDao extends Dao {
    private $studentPhoneNumbersDao;
    protected $table = 'student_phone_numbers';
    protected $primaryKeyField = ['maya_hostels_student_id', 'phone_number'];

    function init(){
        $this->entity = new StudentPhoneNumbers();
    }
}