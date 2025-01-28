<?php

class DatabaseHelper {
    public $hostname;
    public $username;
    public $password;
    public $database;
    public $port;

    public function __construct($config){
        $path = __DIR__. '/lib/classes/Database and Configurations/Database.json';
        if(file_exists($path)){
            $databaseContents = file_get_contents($path);
            if($databaseContents){
                $retrieve_database_contents = json_decode($databaseContents);
                $databaseObjects = $retrieve_database_contents->database->{$config};

                $this->hostname = $databaseObjects->host;
                $this->username = $databaseObjects->user;
                $this->password = $databaseObjects->password;
                $this->database = $databaseObjects->database;
                $this->port = $databaseObjects->port;
            }
        }
    }
}