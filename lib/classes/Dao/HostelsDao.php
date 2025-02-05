<?php

class HostelsDao extends Dao{
    private $hostelsDao;
    protected $table = 'hostels';
    protected $primaryKeyField = 'maya_hostels_hostel_id';

    function init(){
        $this->entity = new Hostels();
    }
}