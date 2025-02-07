<?php

require_once('autoloader.php');

//database configuration
$databaseConfig = new DatabaseHelper('default');

//Creating the Query Builder Objects
$mySqlQueryBuilder = new MySQLQueryBuilder();
$postgresQueryBuilder = new PostgresQueryBuilder();

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
$adminDao = new AdminDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['admin'] = $adminDao;

$adminEmailAddressesDao = new AdminEmailAddressesDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['adminEmailAddresses'] = $adminEmailAddressesDao;

$hostelsDao = new HostelsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['hostels'] = $hostelsDao;

$hostelImagesDao = new HostelImagesDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['hostelImages'] = $hostelImagesDao;

$rooms = new RoomsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['rooms'] = $roomsDao;

$bedspaces = new BedspacesDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['bedspaces'] = $bedspacesDao;

$students = new StudentsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['students'] = $studentsDao;

$studentPhoneNumbers = new StudentPhoneNumbersDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['studentPhoneNumbers'] = $studentPhoneNumbersDao;

$studentGuardianPhoneNumbers = new StudentGuardianPhoneNumbersDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['studentGuardianPhoneNumbers'] = $studentGuardianPhoneNumbersDao;

$studentEmailAddresses = new StudentEmailAddressesDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['studentEmailAddresses'] = $studentEmailAddressesDao;

$accounts = new AccountsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['accounts'] = $accountsDao;

$notifications = new NotificationsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['notifications'] = $notificationsDao;

$ratings = new RatingsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['ratings'] = $ratingsDao;

$complaints = new ComplaintsDao($mySqlSingleton, $mySqlQueryBuilder, $daos, $sessionCaching);
$daos['complaints'] = $complaintsDao;





