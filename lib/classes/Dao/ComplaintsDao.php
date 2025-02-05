<?php

class ComplaintsDao extends Dao{
    private $complaintsDao;
    protected $table = 'complaints';
    protected $primaryKeyField = 'maya_hostels_complaints_id';


    function init(){
        $this->entity = new Complaints();
    }
}