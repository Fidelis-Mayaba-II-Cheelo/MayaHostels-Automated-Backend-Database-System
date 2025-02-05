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
//adding the daos objects to the array of daos in the order of which ones dont have relationships and which ones have
$adminDao = new AdminDao($mySqlSingleton, $daos, $sessionCaching);
$daos['admin'] = $adminDao;





