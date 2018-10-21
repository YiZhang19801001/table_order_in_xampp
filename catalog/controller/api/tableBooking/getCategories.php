<?php 
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
//include db class
include_once './config/Database.php';
include_once './models/Category_description.php';

// Instantiate DB & connect
  $database = new Database();
  $db = $database->connect();

  // Instantiate category_description object
  $category_description = new Category($db);

  // category_description query
  $result = $category_description->read();
  // Get row count
  $num = $result->rowCount();

  // Check if any category_description
  if($num > 0) {
    // category_description array
    $category_descriptions_arr = array();
    // $category_descriptions_arr['data'] = array();

    while($row = $result->fetch(PDO::FETCH_ASSOC)) {
      //could read row elements directly
      extract($row);

      $category_description_item = array(
        'category_id'=>$category_id,
        'category_name' => $name
      );

      // Push to "data"
      array_push($category_descriptions_arr, $category_description_item);
    }

    // Turn to JSON & output
    echo json_encode($category_descriptions_arr);

  } else {
    // No Posts
    echo json_encode(
      array('message' => 'No Posts Found')
    );
  }


