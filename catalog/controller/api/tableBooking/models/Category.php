<?php 
  class Category_description {
    // DB stuff
    private $conn;
    private $table = 'oc_category_description';

    // Post Properties
    
    public $category_id;
    public $language_id;
    public $name;
    public $description;
    public $meta_title;
    public $meta_description;
    public $meta_keyword;

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