<?php

require_once('autoloader.php');

//database configuration
$databaseConfig = new DatabaseHelper('default');

//Specific database connection configurations
$mySqlSingleton = MySQLSingleton::getInstance();
$pdoSingleton = PDOSingleton::getInstance();

//Caching mechanisms
$fileCaching = new FileCache();
$sessionCaching = new SessionCache();
$memoryCaching = new MemCache();

//Creating an array of daos
$daos = [];
$accountsDao = new AccountsDao();





