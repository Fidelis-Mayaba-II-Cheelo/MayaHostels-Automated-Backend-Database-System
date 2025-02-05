<?php

class StudentGuardianPhoneNumbersDao extends Dao {
    private $studentGuardianPhoneNumbersDao;
    protected $table = 'student_guardian_phone_numbers';
    protected $primaryKeyField = ['maya_hostels_student_id', 'guardian_phone_number'];

    function init(){
        $this->entity = new StudentGuardianPhoneNumbers();
    }
}