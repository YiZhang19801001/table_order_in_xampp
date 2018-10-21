<?php

class Product_to_category{
    // DB stuff
    private $conn;
    private $table = 'oc_product_to_category';

    // Properties
    public $product_id;
    public $category_id;

    // Constructor with DB
    public function __construct($db) {
      $this->conn = $db;
    }

    // Get Posts
    public function read() {
      // Create query
      $query = 'SELECT * FROM ' . $this->table;
      
      // Prepare statement
      $stmt = $this->conn->prepare($query);

      // Execute query
      $stmt->execute();

      return $stmt;
    }  

}