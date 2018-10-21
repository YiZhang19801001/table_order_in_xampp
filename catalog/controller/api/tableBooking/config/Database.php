<?php
include_once '../../../../../config.php';

class Database {
//configuration of database
//$timezone = date_default_timezone_set("Australia/Sydney");

//$conn = mysqli_connect(DB_HOSTNAME,DB_USERNAME,DB_PASSWORD,DB_DATABASE);


    // DB Params
    private $host = DB_HOSTNAME;
    private $db_name = DB_DATABASE;
    private $username = DB_USERNAME;
    private $password = DB_PASSWORD;
    private $conn;

    // DB Connect
    public function connect() {
        $this->conn = null;

        try { 
        $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' . $this->db_name, $this->username, $this->password);
        $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
        echo 'Connection Error: ' . $e->getMessage();
        }

        return $this->conn;
    }
}



