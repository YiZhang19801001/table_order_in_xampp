<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTempPickedOption extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('temp_pickedOptions', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('order_item_id');
            $table->string("option_name");
            $table->string("pickedOption");
            $table->integer("product_id");
            $table->timestamps();

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('temp_pickedOptions');
    }
}
