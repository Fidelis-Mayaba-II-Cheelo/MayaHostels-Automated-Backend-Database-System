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

$adminEmailAddressesDao = new AdminEmailAddressesDao($mySqlSingleton, $daos, $sessionCaching);
$daos['adminEmailAddresses'] = $adminEmailAddressesDao;

$hostelsDao = new HostelsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['hostels'] = $hostelsDao;

$hostelImagesDao = new HostelImagesDao($mySqlSingleton, $daos, $sessionCaching);
$daos['hostelImages'] = $hostelImagesDao;

$rooms = new RoomsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['rooms'] = $roomsDao;

$bedspaces = new BedspacesDao($mySqlSingleton, $daos, $sessionCaching);
$daos['bedspaces'] = $bedspacesDao;

$students = new StudentsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['students'] = $studentsDao;

$studentPhoneNumbers = new StudentPhoneNumbersDao($mySqlSingleton, $daos, $sessionCaching);
$daos['studentPhoneNumbers'] = $studentPhoneNumbersDao;

$studentGuardianPhoneNumbers = new StudentGuardianPhoneNumbersDao($mySqlSingleton, $daos, $sessionCaching);
$daos['studentGuardianPhoneNumbers'] = $studentGuardianPhoneNumbersDao;

$studentEmailAddresses = new StudentEmailAddressesDao($mySqlSingleton, $daos, $sessionCaching);
$daos['studentEmailAddresses'] = $studentEmailAddressesDao;

$accounts = new AccountsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['accounts'] = $accountsDao;

$notifications = new NotificationsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['notifications'] = $notificationsDao;

$ratings = new RatingsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['ratings'] = $ratingsDao;

$complaints = new ComplaintsDao($mySqlSingleton, $daos, $sessionCaching);
$daos['complaints'] = $complaintsDao;





