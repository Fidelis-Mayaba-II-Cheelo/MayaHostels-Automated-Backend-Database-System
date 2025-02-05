<?php

class AdminEmailAddressesDao extends Dao{
    private $adminEmailAddressesDao;
    protected $table = 'admin_email_addresses';
    protected $primaryKeyField = ['maya_hostels_admin_id', 'email_address'];

    function init(){
        $this->entity = new AdminEmailAddresses();
    }
}