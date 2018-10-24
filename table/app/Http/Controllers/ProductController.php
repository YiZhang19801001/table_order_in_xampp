<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product_description;
use App\Product_to_category;
use App\Category_description;
use App\Product;
use App\Product_ext;
use App\Product_add_type;
use App\Option_description;
use App\Option_value;
use App\Option_value_description;
use App\Product_option_value;

class ProductController extends Controller
{
    public function index()
    {
        /**
         * need for displaying:
         * {
         *  cateory name:string,
         *  products: [
         *      {
         *          product_name: string,
         *          product_description: string,
         *          product_choices: [
         *              {
         *                  add_type_name:string,
         *                  choice_items: [
         *                      product_ext_name,
         *                      price
         *                  ]
         *              }
         *          ]
         *      }
         * ]
         * }
         */




        //fetch all categories, used for grouping products
        $categories = Category_description::all();

        //declare an array to store the new objs
        $result=[];

        //loop cateogries to generate groups of products for showing in view
        foreach ($categories as $category) {
            $p_ids = Product_to_category::where('category_id',$category->category_id)->get();
            $category_products=[];
            foreach ($p_ids as $id) {

                $new_product = Product_description::where('product_id',$id->product_id)->first();
                //add price attribute to each product
                //fetch price first
                $price = Product::where('product_id',$id->product_id)->first()->price;
                $posOfdecimal = strpos($price,".");
                //cut after 2 digts decimal point
                $length = $posOfdecimal + 3;

                $price = substr($price,0,$length);
                //add to exsiting object
                $new_product->price = $price;
                //add product code to obj
                $new_product->upc = Product::where('product_id',$id->product_id)->first()->upc;
                //add choices for each item
                //fetching all choice for each product
                $choices = Product_ext::where('product_id',$id->product_id)->get();

                //group choices by type
                // ToDo: fix this ugly logic
                /**
                 * fetch all add_types and then assign $choices to each type, remove array.length == 0
                 */


                $add_types = Product_add_type::all();
                $productChoiceList = array();
                foreach ($add_types as $type) {

                    $listByType = array();
                    foreach ($choices as $choice) {
                        if($choice->type === $type->add_type_id)
                        {
                            array_push($listByType, $choice);
                        }
                    }
                    if(count($listByType)>0){
                        array_push($productChoiceList,array("type"=>$type->name,"choices"=>$listByType));
                    }
                }
                $new_product->choices= $productChoiceList;
                /**need assign option as well */
                /**
                 * 1. use product id found all records in oc_product_option_value
                 * 2. option_id found option_name
                 * 3. option_value_id found option_value_name
                 * 4. should output an array
                */
                $productOptionList = array();
                $productOptionValueList = Product_option_value::where('product_id',$id->product_id)->get();

                $option_ids = Product_option_value::where('product_id',$id->product_id)->select('option_id')->distinct()->get();


                foreach ($option_ids as $option_id) {
                    /**add option name & language_id,sort_order to the obj */

                    $option_name = Option_description::where('option_id',$option_id->option_id)->first()->name;

                    /**ToDo: may use for display*/
                    // $language_id = Option_description::where('option_id',$option_id)->first()->language_id;
                    // $sort_order = Option::where('option_id',$option_id)->first()->sort_order;

                    /**create option value group */
                    $option_value_group = array();

                    foreach ($productOptionValueList as $product_option_value) {

                        if($product_option_value->option_id === $option_id->option_id){
                            /**add option_value name, sort_order to the obj */
                            $option_value_id = $product_option_value->option_value_id;

                            /**Todo: fix option_value_sort_order always null */
                            $option_value_sort_order = Option_value::where('option_value_id',$option_value_id)->first()->sort_dorder;
                            $option_value_name = Option_value_description::where('option_value_id',$option_value_id)->first()->name;

                            $new_option_value=array();

                            $new_option_value["product_option_value_id"] = $product_option_value->product_option_value_id;
                            $new_option_value["option_value_name"] = $option_value_name;
                            $new_option_value["option_value_sort_order"] = $option_value_sort_order;
                            /**parse price to float */
                            $price = $product_option_value->price;
                            $posOfdecimal = strpos($price,".");
                            //cut after 2 digts decimal point
                            $length = $posOfdecimal + 3;
                            $price = substr($price,0,$length);

                            $new_option_value["price"] = $price;

                            array_push($option_value_group,$new_option_value);
                            /**[
                                {
                                    "product_option_value_id": 22,
                                    "option_value_name": "Small",
                                    "option_value_sort_order": null,
                                    "price": "2.0000"
                                }
                            ] */
                        }
                    }

                    /**add new option with value group to array */
                    $new_productOption = array("option_id"=>$option_id,"option_name"=>$option_name,"option_values"=>$option_value_group);

                    array_push($productOptionList,$new_productOption);
                }



                $new_product->options= $productOptionList;
                //save certain products
                array_push($category_products,$new_product);
            }
            $new_category = ["categorys"=>$category,"products"=>$category_products];
            array_push($result,$new_category);

        }

        //return
        return response()->json([
            "products" => $result
        ], 200);

    }
}
