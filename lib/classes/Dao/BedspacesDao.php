<?php

class BedspacesDao extends Dao{
    private $bedspacesDao;
    protected $table = 'bedspaces';
    protected $primaryKeyField = 'maya_hostels_bedspaces_id';

    function init(){
        $this->entity = new Bedspaces();
    }
}