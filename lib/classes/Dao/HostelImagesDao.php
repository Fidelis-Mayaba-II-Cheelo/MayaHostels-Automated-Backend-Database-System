<?php

class HostelImagesDao extends Dao{
    private $hostelImagesDao;
    protected $table = 'hostel_images';
    protected $primaryKeyField = 'maya_hostels_hostel_images_id';

    function init(){
        $this->entity = new HostelImages();
    }
}