<?php

class PDOSingleton extends DatabaseHelper implements IDatabaseHelper
{
    private static $instance = null;
    private $pdo;

    public function __construct()
    {
        parent::__construct();
        $dsn = 'mysql:host=' . $this->hostname . ';port=' . $this->port . ';dbname=' . $this->database;
        try {
            $this->pdo = new PDO($dsn, $this->username, $this->password);
            $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (Exception $ex) {
            throw new Exception("PDO connection error" . $ex->getMessage());
        }
    }

    public static function getInstance(): IDatabaseHelper
    {
        if (self::$instance == null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection()
    {
        return $this->pdo;
    }

    private function __clone() {}

    private function __wakeup() {}
}
