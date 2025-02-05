<?php

class StudentDao extends Dao{
    private $studentDao;
    protected $table = 'students';
    protected $primaryKeyField = 'maya_hostels_student_id';

    function init(){
        $this->entity = new Student();
    }
}