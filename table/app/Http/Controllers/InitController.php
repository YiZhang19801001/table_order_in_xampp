<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class InitController extends Controller
{
    public function index(){
        /**create config file */
        $language_id = env("MIX_APP_LAN");
        switch ($language_id) {
            case 1:
                $app_conf = \Config::get('language_en');
                break;

            case 2:
                $app_conf = \Config::get('language_cn');
                break;

            default:
                $app_conf = \Config::get('language_en');
                break;
        }

        $app_conf["show_option"] = env("MIX_SHOW_OPTIONS");

        return response()->json([
            "app_conf" => $app_conf
        ], 200);
    }
}
