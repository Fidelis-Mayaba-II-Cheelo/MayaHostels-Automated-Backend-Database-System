<?php

class AdminDao extends Dao{
    private $adminDao;
    protected $table = 'admin';
    protected $primaryKeyField = 'maya_hostels_admin_id';

    function init(){
        $this->entity = new Admin();
    }
}