<?php

class MySQLSingleton extends DatabaseHelper implements IDatabaseHelper {

    private static $instance = null;
    private $mysqli;

    public function __construct()
    {
        parent::__construct();
        try{
            $this->mysqli = new mysqli(
                $this->hostname, $this->username, $this->password, $this->database, $this->port
            );
        } catch(Exception $ex){
            throw new Exception("MySQL Database Connection Error: " . $ex->getMessage());
        } 
    }

    public static function getInstance():IDatabaseHelper{
        if(self::$instance == null){
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection()
    {
        return $this->mysqli;
    }
}