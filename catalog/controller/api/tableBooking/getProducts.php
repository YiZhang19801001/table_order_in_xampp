<?php 
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
//include db class
include_once './config/Database.php';
include_once './models/Category.php';
include_once './models/Product.php';
include_once './models/Product_to_category.php';

// Instantiate DB & connect
  $database = new Database();
  $db = $database->connect();

  // Instantiate product object
  $product = new Product($db);
  $ategory = new Category($db);
  $product_to_category = new Product_to_category($db);

  //  query
  $result_product = $product->read();
  $result_category = $ategory->read();
  $result_product_to_category = $product_to_category->read();

  // Get row count
  $num = $result_category->rowCount();

  // Check if any product
  if($num > 0) {


    while($row = $result_category->fetch(PDO::FETCH_ASSOC)) {
        //group same products in same category together
        //could read row elements directly
        extract($row);

        // product array
        $products_arr = array();

        $product_item = array(
            'product_id'=>$product_id,
            'category_name' => $name
        );

        $product_group = array(
            'category'=>category
        );
        // Push to "data"
        array_push($products_arr, $product_group);
    }

    // Turn to JSON & output
    echo json_encode($products_arr);

  } else {
    // No Posts
    echo json_encode(
      array('message' => 'No Posts Found')
    );
  }


