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

//Adding the daos objects to the array of daos in the order of which ones dont have relationships and which ones have
//We do this because we need the DAO to keep track of each individual Daos object for their respective CRUD operations
//Every DAO object needs their own instance of the query adapter object so we dont mix up their CRUD operations
$adminDao = new AdminDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['admin'] = $adminDao;

$adminEmailAddressesDao = new AdminEmailAddressesDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['adminEmailAddresses'] = $adminEmailAddressesDao;

$hostelsDao = new HostelsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['hostels'] = $hostelsDao;

$hostelImagesDao = new HostelImagesDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['hostelImages'] = $hostelImagesDao;

$rooms = new RoomsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['rooms'] = $roomsDao;

$bedspaces = new BedspacesDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['bedspaces'] = $bedspacesDao;

$students = new StudentsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['students'] = $studentsDao;

$studentPhoneNumbers = new StudentPhoneNumbersDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['studentPhoneNumbers'] = $studentPhoneNumbersDao;

$studentGuardianPhoneNumbers = new StudentGuardianPhoneNumbersDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['studentGuardianPhoneNumbers'] = $studentGuardianPhoneNumbersDao;

$studentEmailAddresses = new StudentEmailAddressesDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['studentEmailAddresses'] = $studentEmailAddressesDao;

$accounts = new AccountsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['accounts'] = $accountsDao;

$notifications = new NotificationsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['notifications'] = $notificationsDao;

$ratings = new RatingsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['ratings'] = $ratingsDao;

$complaints = new ComplaintsDao(new MySQLQueryAdapter($mySqlSingleton, $mySqlQueryBuilder), $daos, $sessionCaching);
$daos['complaints'] = $complaintsDao;





