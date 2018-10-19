<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product_description;
use App\Product_to_category;
use App\Category_description;
use App\Product;
use App\Product_ext;
use App\Product_add_type;

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
