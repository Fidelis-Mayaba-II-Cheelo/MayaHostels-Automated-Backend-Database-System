<?php

class AccountsDao extends Dao{
    private $accountsDao;
    protected $table = 'accounts';
    protected $primaryKeyField = 'maya_hostels_accounts_id';

    function init(){
        $this->entity = new Accounts();
    }

}