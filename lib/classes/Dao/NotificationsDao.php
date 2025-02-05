<?php

class NotificationsDao extends Dao{
    private $notificationsDao;
    protected $table = 'notifications';
    protected $primaryKeyField = 'maya_hostels_notifications_id';

    function init(){
        $this->entity = new Notifications();
    }
}