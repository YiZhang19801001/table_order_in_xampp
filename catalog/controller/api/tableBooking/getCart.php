<?php 
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
//include db class

include '../../../../system/engine/model.php';
include_once '../../../../system/library/cart.php';
include_once '../../../../system/library/db.php';
include_once '../../../../config.php';
include '../../../../catalog/model/shop/list.php';





// Database // Bug:: can not open driver mysql
//$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE,DB_PORT);

$list = new ModelShopList;

$arr = $list->getTagNameByid(1);
    // No Posts
    echo json_encode(
      array('message' => $arr)
    );
  


