<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Category_description;

class categoryController extends Controller
{
       public function index()
    {

        //fetch category_descriptions from database
        $categories = Category_description::all();
        //return
        return response()->json([
            "categories" => $categories
        ], 200);

    }
}
