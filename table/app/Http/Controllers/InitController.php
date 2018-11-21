<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class InitController extends Controller
{
    public function index($lang){
        /**create config file */
        //$language_id = config("app.lang");
        $language_id = $lang;

        /** mapping values for app_conf */

        switch ($language_id) {
            case 1:
                $app_conf        = \Config::get('language_en');
                break;

            case 2:
                $app_conf        = \Config::get('language_cn');
                break;

            default:
                $app_conf        = \Config::get('language_en');
                break;
        }


        $app_conf["show_option"] = config("app.show_options");

        /**return app_conf to client side */
        return response()->json([
            "app_conf" => $app_conf
        ], 200);
    }
}
