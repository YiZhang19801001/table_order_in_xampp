<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Category_description;

class categoryController extends Controller
{
    public function index($lang)
    {
        //fetch app_conf
        //$lang = config("app.lang");

        //this is the result
        $categories = array();

        //fetch category_descriptions from database
        $categories_in_db = Category_description::where('language_id',$lang)->get();

        //mapping value
        foreach ($categories_in_db as $category_in_db) {
            $category["category_id"] = $category_in_db["category_id"];
            $category["name"] = $category_in_db["name"];

            array_push($categories,$category);
        }

        //return
        return response()->json([
            "categories" => $categories
        ], 200);

    }
}
