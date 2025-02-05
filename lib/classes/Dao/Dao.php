<?php

class Dao {
    //The database names
    protected $database;
    //The table names
    protected $table;
    //The primary key fields
    protected $primaryKeyField;
    //The particular Entity
    protected ?Entity $entity;
    //Array of Data Access Objects
    protected array $daos = [];
    //Array of Database fields
    protected array $fields = [];
    //Pagination page size
    protected $pageSize = 10;

    public function __construct(IDatabaseHelper $database, array $daos=[]){
        $this->database = $database;
        if($daos){
            $this->daos = $daos;
        }

        //Means that current Dao object ($this) is being stored in the $daos array using the value of $this->table as the key
        $this->daos[$this->table] = $this;

        $this->init();
    }

    public function init(){
        throw new Exception("Call from child class");
    }

    public function save(Entity $entity){

    }

    public function findAll(){

    }

    public function findById($id){

    }

    public function findBySearchTerm($searchterm){

    }

    public function delete($id){

    }

    public function drop(){

    }
}