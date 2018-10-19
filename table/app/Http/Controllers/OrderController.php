<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use App\Order;
use App\Order_product;
use App\Events\newOrderItemAdded;
use App\Temp_order_item;
use App\Temp_pickedChoice;
use App\Product_description;
use App\Product;
use App\Product_add_type;
use App\Product_ext;
use App\Temp_order;

class OrderController extends Controller
{
    public function __construct(){
    }

    /** Todo:
     * 1. save orderList to database table
     * 2. create broadcast
     * 3. get newest order list*/

    public function post(Request $request)
    {


        $new_item = $request->orderItem;
        /**check new item already in the list or not
         * if already have then update the quantity only
         * else insert as new recorder in temp_order_items table
        */
        $alreadyHave = false;
        /**to determin is the new_item already have or not, should chenck 2 things
         * 1. if their is a product_id match? not-> insert new, yes->fetch id
         * 2. find $id as $order_item_id in temp_pickChoice table. will get an arr_choices
         * 3. check arr_choices->(choice_type,piced_Choice) and $new_item->choices(choice_type,piced_Choice) is matched or not. no->insert new, yes->increate the quantity in temp_order_items table
         */

         /** 1. may return an array which is same as new_item but may with different taste*/
        $arr_order_items = Temp_order_item::where('product_id',$new_item["product_id"])->where('order_id',$request->orderId)->get();

        /** if array is empty then insert straight away */
        if(count($arr_order_items)<1){
            $this->createOrderHelper($new_item,$request->orderId);
        }
        /**if array is not empty then further checking the taste */
        else{
            /**check 3 columns type, picked_Choice and order_item_id */
            foreach ($arr_order_items as $order_item) {
                /** order_item_id && choice_type will get single record then compare with the params */
                foreach ($new_item["choices"] as $new_choice) {
                    $choice_in_DB = Temp_pickedChoice::where("order_item_id",$order_item["id"])->where("choice_type",$new_choice["type"])->first();
                    if($choice_in_DB["picked_Choice"]==$new_choice["pickedChoice"]){
                        $alreadyHave = true;
                    }else{
                        $alreadyHave = false;
                        break;
                    }
                }
                if ($alreadyHave) {
                    Temp_order_item::where('id',$order_item["id"])->increment('quantity');

                    /**record found stop the loop, otherwise duplicate record will add */
                    break;
                }

            }
            if(!$alreadyHave){
                $this->createOrderHelper($new_item,$request->orderId);
            }

        }

        $order = $this->fetchOrderListHelper($request->orderId);
        broadcast(new newOrderItemAdded($request->orderId));
       return response()->json($order);
    }

    /** read: this action only for the newcomer to fetch the up to date order list once */
    public function getCart(Request $request)
    {
        $order = $this->fetchOrderListHelper($request->order_id);

        return response()->json($order);
    }


    /**
     * create new order request will contain an object with info of an single order
     */
    public function create(Request $request)
    {
        //create new record in order table


        $order =new Temp_order;
        $order->table_number = $request->table_number;
        $order->save();

        $orderId = $order->id;

        //return
        return response()->json([
            "orderId" => $orderId
        ], 200);

    }


    public function increase(Request $request){
        $target_item = $request->orderItem;
        $order_id = $request->orderId;


        Temp_order_item::whereId($target_item["item"]["order_item_id"])->increment("quantity");

       broadcast(new newOrderItemAdded($request->orderId));

        return $target_item;

    }

    public function decrease(Request $request){
    $target_item = $request->orderItem;
    $order_id = $request->orderId;


        Temp_order_item::whereId($target_item["item"]["order_item_id"])->decrement("quantity");




    broadcast(new newOrderItemAdded($request->orderId));

    return $target_item;

    }


    public function createOrderHelper($new_item,$orderId){
        $new_order_item = new Temp_order_item;
        $new_order_item->pickedChoice = "abc";
        $new_order_item->quantity = 1;
        $new_order_item->product_id = $new_item["product_id"];
        $new_order_item->order_id = $orderId;
        $new_order_item->save();

        foreach ($new_item["choices"] as $choice) {
            $new_pickedChoice = new Temp_pickedChoice;
            $new_pickedChoice->order_item_id = $new_order_item->id;
            $new_pickedChoice->choice_type = $choice["type"];
            $new_pickedChoice->picked_Choice = $choice["pickedChoice"];

            $new_pickedChoice->save();
        }
    }

    public function fetchOrderListHelper($id){
    /**1. from 'order_id' fetching or order_items
     * 2. from 'order_item' table get 'product_id', fron those id get details of products from product table
     */
    $order=[]; //result container
    $order_id = $id;



    $arr_order_items = Temp_order_item::where('order_id',$order_id)->where('quantity','>',0)->get();

    if(count($arr_order_items)<1){
        return $order;
    }
    foreach ($arr_order_items as $order_item) {
        $new_orderList_ele=array();
        $new_orderList_ele["quantity"] = $order_item["quantity"];

        $targe_product = Product_description::where('product_id',$order_item["product_id"])->first();
        $new_orderList_ele["item"] = $targe_product;
        //add price attribute to each product
        //fetch price first
        $price = Product::where('product_id',$order_item["product_id"])->first()->price;
        $posOfdecimal = strpos($price,".");
        //cut after 2 digts decimal point
        $length = $posOfdecimal + 3;
        $price = substr($price,0,$length);
        //add to exsiting object
        $new_orderList_ele["item"]->price = $price;
        $new_orderList_ele["item"]->order_item_id = $order_item["id"];

        $pickedChoices = Temp_pickedChoice::where('order_item_id',$order_item["id"])->get();

        /** Temp_pickedChoice table has column "choice_type" == "name" in add_type
         * then we can get add_type_id which relative to "type" in product_ext, and name in prodcut_ext
         * should group as a new array to match the format of data.
        */
        $productChoiceList = [];

        foreach ($pickedChoices as $pickChoice) {
            $type = Product_add_type::where('name',$pickChoice["choice_type"])->first();
            $choices = Product_ext::where('type',$type->add_type_id)->get();

            array_push($productChoiceList,array("type"=>$type->name,"choices"=>$choices,"pickedChoice"=>$pickChoice["picked_Choice"]));
        }

        $new_orderList_ele["item"]["choices"] = $productChoiceList;
        array_push($order,$new_orderList_ele);
    }
    return $order;
    }

}
