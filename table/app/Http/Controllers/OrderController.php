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
use App\Order_history;
use App\Order_total;
use App\Order_ext;
use App\Table_link;
use App\Temp_pickedOption;
use App\Order_option;

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
        $mode = config('app.show_options');
        $new_item = $request->orderItem;
        $arr_order_items = Temp_order_item::where('product_id',$new_item["product_id"])->where('order_id',$request->orderId)->get();

        /** if array is empty then insert straight away */
        if(count($arr_order_items)<1){
            $this->createOrderHelper($new_item,$request->orderId,$mode);
        }else if(!$mode)
        /**if $mode is false, no options showed, only check product_id is already in the temp_order_item or not */
        {
            Temp_order_item::where('id',$arr_order_items[0]["id"])->increment('quantity');
        }else
        /**if $mode is true, further check */
        {
            /**check new item already in the list or not
             * if already have then update the quantity only
             * else insert as new recorder in temp_order_items table
            */
            $alreadyHave = false; //flag for ext
            $optionIsSame= false; //flag for option

            /**to determin is the new_item already have or not, should check TWO things
             * Step 1. if their is a product_id match? not-> insert new, yes-> go step 2
             * Step 2. find $id as $order_item_id in temp_pickChoice table. will get an arr_choices
             * Step 3. check arr_choices->(choice_type,piced_Choice) and $new_item->choices(choice_type,piced_Choice) is matched or not. no->insert new, yes->increate the quantity in temp_order_items table
             */

            /** 1. return an array which is same product_id as new_item, but may with different taste or options*/
            $arr_order_items = Temp_order_item::where('product_id',$new_item["product_id"])->where('order_id',$request->orderId)->get();

            /**check 3 columns type, picked_Choice and order_item_id */
            foreach ($arr_order_items as $order_item) {
                if(count($new_item["choices"])!=0){
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
                }else{
                    $alreadyHave = true;
                }
                if(count($new_item["options"])!=0){
                    foreach ($new_item["options"] as $new_option) {
                        $option_in_DB = Temp_pickedOption::where("order_item_id",$order_item["id"])->where("option_name",$new_option["option_name"])->first();
                        if($option_in_DB["pickedOption"]==$new_option["pickedOption"]){
                            $optionIsSame = true;
                        }
                        else{
                            $optionIsSame=false;
                            break;
                        }
                    }
                }
                else{
                    $optionIsSame = true;
                }
                if ($alreadyHave && $optionIsSame) {
                    Temp_order_item::where('id',$order_item["id"])->increment('quantity');

                    /**record found stop the loop, otherwise duplicate record will add */
                    break;
                }

            }
            //use for debuging.
            //return response()->json(["alreadyHave"=>$alreadyHave,"optionIsSame"=>$optionIsSame]);
            if(!$alreadyHave || !$optionIsSame){
                $this->createOrderHelper($new_item,$request->orderId);
            }
        }
        $order = $this->fetchOrderListHelper($request->orderId,$request->table_id);
        broadcast(new newOrderItemAdded($request->orderId));
        return response()->json($order);
    }

    /** fetch the up to date order list once */
    public function getCart(Request $request)
    {
    /**validate users */
        //check if this QRcode contain all infos with correct format
        if($request->cdt==null||$request->v==null){
            return response()->json(["message"=>"this QR Code is invalid, please contact staff!"],400);
        }

        //mapping value for further valided
        $cdt =  $request->cdt;
        $v =$request->v;

        //check if this QRcode valid in DB
        $new_table_link = Table_link::where('validation',$v)->first();
        //$new_table_link === null => QRcode is not valid
        if($new_table_link === null || $new_table_link->status!==0){
            return response()->json(["message"=>"this QR Code is invalid, please contact staff!"],400);
        }
        //check timestamp
        if($new_table_link!==null){
            //reformat income time
            $time = strtotime($cdt);
            $day = date('y-m-d',$time);

            //reformat time in DB
            $time_in_db = strtotime($new_table_link->link_generate_time);
            $day_in_db = date('y-m-d',$time_in_db);

            //check matched or not
            if($day != $day_in_db){
                return response()->json(["message"=>"this QR Code is incorrect, please contact staff!"],400);
            }
        }
    /**end validation */

        $order = $this->fetchOrderListHelper($request->order_id,$request->table_id);
        return response()->json($order);
    }


    public function fetchOrderListHelper($order_id,$table_id){

        /** step 1. check there is a temp order for this or not=> yes: fetch order details, no: create new Temp_order */
        $order_to_table = Temp_order::where('id',$order_id)->where('table_number',$table_id)->first();

        //call help method to CREATE NEW TEMP_ORDER
        if($order_to_table === null)
        {
            $this->create($order_id,$table_id);
        }


        /**1. from 'order_id' fetching order_items
         * 2. from 'order_item' table get 'product_id',
         * according to those ids get details of products from product table
         */
        $order=[]; //result container

        /** temp_order_items
         * [id:int(10)][quantity:int(11)][product_id:int(11)][order_id:int(11)]
         */
        $arr_order_items = Temp_order_item::where('order_id',$order_id)->where('quantity','>',0)->get();

        /**if $arr_order_items is empty return empty array() */
        if(count($arr_order_items)<1){
            return $order;
        }

        $mode = config('app.show_options');
        /**if $arr_order_items is not empty, build the result array with details */
        /** order_item details need: [name][quantity][price] full detail mode only [ext][option]*/
        foreach ($arr_order_items as $order_item) {
            $new_orderList_ele=array();
            $targe_product = Product_description::where('product_id',$order_item["product_id"])->first();
            $upc = Product::where('product_id',$order_item["product_id"])->first()->upc;
        /**make price */
            //fetch price first
            $price = Product::where('product_id',$order_item["product_id"])->first()->price;
            $posOfdecimal = strpos($price,".");
            //cut after 2 digts decimal point
            $length = $posOfdecimal + 3;
            $price = substr($price,0,$length);
        /**END */


            //mapping values
            $new_orderList_ele["item"]["order_item_id"] = $order_item["id"];
            $new_orderList_ele["item"]["product_id"]    = $order_item["product_id"];
            $new_orderList_ele["quantity"]              = $order_item["quantity"];
            $new_orderList_ele["item"]["name"]          = $targe_product["name"];
            $new_orderList_ele["item"]["price"]         = $price;
            $new_orderList_ele["item"]["upc"]           = $upc;
        /**append options & exts only needed when mode is show options */

            if($mode)
            {
                //ToDo: add price for choice
                /**temp_pickedchoices
                 * [id:int(10)][order_item_id:int(11)][choice_type:varchar(255)][picked_Choice:varchar(255)]
                 */
                $pickedChoices = Temp_pickedChoice::where('order_item_id',$order_item["id"])->get();

                $productChoiceList = [];

                foreach ($pickedChoices as $pickChoice) {
                    $type = Product_add_type::where('name',$pickChoice["choice_type"])->first();

                    //$choices = Product_ext::where('type',$type->add_type_id)->get();

                    array_push($productChoiceList,array(
                        "type"=>$type->name,
                        "pickedChoice"=>$pickChoice["picked_Choice"],
                        "price"=>$pickChoice["price"],
                        "product_ext_id"=>$pickChoice["product_ext_id"]));
                }

                $new_orderList_ele["item"]["choices"] = $productChoiceList;

                /**grab all information for options */
                $pickedOptions = Temp_pickedOption::where('order_item_id',$order_item["id"])->get();

                $productOptionList = [];
                foreach ($pickedOptions as $pickOption) {
                    /**get optionValues */
                    /** option_id && product_id can found unique [product_option_value_id] [price] [option_value_id]
                     * [option_value_name] ->use [option_value_id] find this from [oc_option_value_description]
                     * [option_value_sort_order] ->use [option_value_id] find this from [oc_option_value]
                    */

                    //Todo: may need list of options
                    // $optionValues = array();
                    // foreach ($variable as $key => $value) {
                    //     # code...
                    // }

                    array_push($productOptionList,array(
                    "option_id"                 =>$pickOption["option_id"],
                    "option_name"               =>$pickOption["option_name"],
                    "pickedOption"              =>$pickOption["pickedOption"],
                    "price"                     =>$pickOption["price"],
                    "product_option_value_id"   =>$pickOption["product_option_value_id"]
                    //"option_values"             =>$optionValues
                    ));
                }
                $new_orderList_ele["item"]["options"] = $productOptionList;
            }

        /**End */
            array_push($order,$new_orderList_ele);
        }
        return $order;
    }

    /**
     * create new order request will contain an object with info of an single order
     */
    public function create($order_id,$table_id)
    {
        //create new record in order table
        $order =new Temp_order;
        $order->table_number = $table_id;
        $order->id           = $order_id;
        $order->save();

        //return
        return response()->json([
            "order" => $order
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

        $mode = config('app.show_options');

        $new_order_item = new Temp_order_item;
        $new_order_item->quantity   = 1;
        $new_order_item->product_id = $new_item["product_id"];
        $new_order_item->order_id   = $orderId;
        $new_order_item->save();

        if(!$mode)
        {
            return; //if $mode is no show options, stop here!!
        }

        foreach ($new_item["choices"] as $choice) {
            $new_pickedChoice = new Temp_pickedChoice;

            $new_pickedChoice->product_ext_id   = $choice["product_ext_id"];
            $new_pickedChoice->order_item_id    = $new_order_item->id;
            $new_pickedChoice->choice_type      = $choice["type"];
            $new_pickedChoice->picked_Choice    = $choice["pickedChoice"];
            $new_pickedChoice->price            = $choice["price"];

            $new_pickedChoice->save();
        }

        foreach($new_item["options"] as $option){
            $new_pickedOption = new Temp_pickedOption;

            $new_pickedOption->order_item_id            = $new_order_item->id;
            $new_pickedOption->product_option_value_id  = $option["product_option_value_id"];
            $new_pickedOption->option_name              = $option["option_name"];
            $new_pickedOption->pickedOption             = $option["pickedOption"];
            $new_pickedOption->price                    = $option["price"];
            $new_pickedOption->product_id               = $new_item["product_id"];
            $new_pickedOption->option_id                = $option["option_id"]["option_id"];

            $new_pickedOption->save();
        }
    }

    public function confirmOrder(Request $request){
        /**request is an array of  */

        //get new order
        $new_order = $this->createOcOrderHelper($request);
        $order_id = $new_order->id;

        $value = $new_order->total;
        //create record in oc_order_history
        $this->createOcOrderHistoryHelper($order_id);

        //create record in oc_order_total
        $this->createOrderTotalHelper($order_id,$value);

        //create record in oc_order_product
        $this->createOrderProductHelper($request->orderList,$order_id);

        return response()->json(["new_order"=>$new_order],200);

    }

    public function createOcOrderHelper($request){
        /**create order in oc_order */
        $new_order = new Order;
        $new_order->invoice_no = 0;
        $new_order->invoice_prefix = "INV-2013-00";
        $new_order->store_id = $request->store_id;//4
        $new_order->store_name=$request->store_name;//Monkey King Thai Restaurant
        $new_order->store_url=$request->store_url;//http://192.168.1.220/
        $new_order->customer_id=0;
        $new_order->customer_group_id = 1;
        $new_order->firstname = " ";
        $new_order->lastname = " ";
        $new_order->email = "tableorder@order2.com";
        $new_order->telephone = " ";
        $new_order->fax = " ";
        $new_order->custom_field = " ";
        $new_order->payment_firstname=" ";
        $new_order->payment_lastname=" ";
        $new_order->payment_company = " ";
        $new_order->payment_address_1=" ";
        $new_order->payment_address_2=" ";
        $new_order->payment_city=" ";
        $new_order->payment_postcode=" ";
        $new_order->payment_country=" ";
        $new_order->payment_country_id=0;
        $new_order->payment_state = " ";
        $new_order->payment_state_id=0;
        $new_order->payment_suburb=" ";
        $new_order->payment_suburb_id=0;
        $new_order->payment_address_format=" ";
        $new_order->payment_custom_field=" ";
        $new_order->payment_code="cod";
        $new_order->payment_method = "DineIn";
        $new_order->shipping_firstname = " ";
        $new_order->shipping_lastname = " ";
        $new_order->shipping_email = "tableorder@order2.com";
        $new_order->shipping_telephone = " ";
        $new_order->shipping_company = " ";
        $new_order->shipping_address_1 = " ";
        $new_order->shipping_address_2 = " ";
        $new_order->shipping_city = " ";
        $new_order->shipping_postcode = " ";
        $new_order->shipping_country = " ";
        $new_order->shipping_country_id = 0;
        $new_order->shipping_state = " ";
        $new_order->shipping_state_id = 0;
        $new_order->shipping_suburb = " ";
        $new_order->shipping_suburb_id = 0;
        $new_order->shipping_address_format = " ";
        $new_order->shipping_custom_field = " ";
        $new_order->shipping_method = "DineIn";
        $new_order->shipping_orderTime = date("H:i");
        $new_order->shipping_orderDate = date_create()->format("D, d M y");
        $new_order->shipping_orderWhen = "now";
        $new_order->shipping_code = " ";
        $new_order->comment = " ";
        $new_order->total =$request->total;
        $new_order->order_status_id=1;
        $new_order->affiliate_id = 0;
        $new_order->commission = 0.0000;
        $new_order->marketing_id = 0;
        $new_order->tracking = " ";
        $new_order->language_id = 1;
        $new_order->currency_id = 4;
        $new_order->currency_code = "AUD";
        $new_order->currency_value = 1.000000;
        //Todo: fetch from request
        $new_order->ip = "192.168.1.220";
        $new_order->forwarded_ip = " ";
        //Todo: fetch from request
        $new_order->user_agent = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36";
        //Todo: fetch from accept_language
        $new_order->accept_language = "en-GB,en-US;q=0.8,en;q=0.6";
        $new_order->date_added = date_create()->format("y-m-d h:i:s");
        $new_order->date_modified = date_create()->format("y-m-d h:i:s");

        //save to database
        $new_order->save();

        //return id
        return $new_order;
    }

    public function createOcOrderHistoryHelper($order_id){
        $new_order_history = new Order_history;
        $new_order_history->order_id = $order_id;
        $new_order_history->notify = 0;
        //Todo: read from new order??
        $new_order_history->order_status_id = 1;
        $new_order_history->comment = " ";
        $new_order_history->date_added = date_create()->format("y-m-d h:i:s");
    }

    public function createOrderTotalHelper($order_id,$value){
        $new_order_total_1 = new Order_total;
        $new_order_total_1->order_id = $order_id;
        $new_order_total_1->code = "sub_total";
        $new_order_total_1->title= "Sub-Total";
        $new_order_total_1->value = $value;
        $new_order_total_1->sort_order = 1;
        $new_order_total_1->save();

        $new_order_total_2 = new Order_total;
        $new_order_total_2->order_id = $order_id;
        $new_order_total_2->code = "shipping";
        $new_order_total_2->title= "Dive-In";
        $new_order_total_2->value = $value;
        $new_order_total_2->sort_order = 3;
        $new_order_total_2->save();

        $new_order_total_3 = new Order_total;
        $new_order_total_3->order_id = $order_id;
        $new_order_total_3->code = "total";
        $new_order_total_3->title= "Total";
        $new_order_total_3->value = $value;
        $new_order_total_3->sort_order = 9;
        $new_order_total_3->save();
    }

    public function createOrderProductHelper($orderList, $order_id){
        $arr_order_items = $orderList;

        foreach ($arr_order_items as $order_product) {
            $new_order_product = new Order_product;
            $new_order_product->order_id = $order_id;
            $new_order_product->product_id =$order_product["item"]["product_id"];
            $new_order_product->model = 1;
            $new_order_product->quantity = $order_product["quantity"];
            $new_order_product->name = $order_product["item"]["name"];
            $new_order_product->price = $order_product["item"]["price"];
            $new_order_product->total = $order_product["quantity"] * (float)$order_product["item"]["price"];
            $new_order_product->tax = 0;
            $new_order_product->reward = 0;

            $new_order_product->save();

            /**picked choices */
            foreach ($order_product["item"]["choices"] as $choice) {
                $new_order_ext = new Order_ext;

                $new_order_ext->product_ext_id = $choice["product_ext_id"];
                $new_order_ext->order_product_id = $new_order_product->id;
                $new_order_ext->product_id = $order_product["item"]["product_id"];

                $new_order_ext->save();
            }
            /**store picked options in DB*/
            foreach($order_product["item"]["options"] as $option){
                $new_order_option = new Order_option;
                $new_order_option->order_id = $order_id;
                $new_order_option->order_product_id = $new_order_product->id;

                $new_order_option->product_option_id= $option["option_id"];

                $new_order_option->product_option_value_id = $option["product_option_value_id"];
                $new_order_option->name = $option["option_name"];
                $new_order_option->value = $option["pickedOption"];
                $new_order_option->type = "radio";

                $new_order_option->save();
            }


        }
    }

}
