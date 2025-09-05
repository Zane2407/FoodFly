<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();

            // Foreign keys
            $table->foreignId('user_id')->nullable()->constrained()->onDelete('set null');
            $table->foreignId('restaurant_id')->constrained()->onDelete('cascade');
            $table->foreignId('menu_item_id')->constrained()->onDelete('cascade');

            // Customer info
            $table->string('customer_name');
            $table->string('customer_phone');
            $table->text('customer_address');

            // Order details
            $table->integer('quantity');
            $table->decimal('total_price', 8, 2);

            $table->enum('status', ['pending', 'confirmed', 'preparing', 'delivered'])
                ->default('pending');

            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('orders');
    }
};
