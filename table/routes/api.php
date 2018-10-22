<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

//list the categories
Route::get('categories','categoryController@index');
Route::get('products','ProductController@index');
// Todo: add order, MUST announce Server
//Route::post('order','OrderController@create');


Route::post('initcart','OrderController@getCart');
Route::post('orderitem','OrderController@post');
Route::post('opentable','OrderController@create');
Route::post('increase','OrderController@increase');
Route::post('decrease','OrderController@decrease');
Route::post('confirm','OrderController@confirmOrder');
