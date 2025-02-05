<?php

class RatingsDao extends Dao{
    private $ratingsDao;
    protected $table = 'ratings';
    protected $primaryKeyField = 'maya_hostels_ratings_id';

    function init(){
        $this->entity = new Ratings();
    }
}