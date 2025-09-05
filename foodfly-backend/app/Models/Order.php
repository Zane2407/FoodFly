<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'restaurant_id',
        'menu_item_id',
        'customer_name',
        'customer_phone',
        'customer_address',
        'quantity',
        'total_price',
        'status'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function restaurant()
    {
        return $this->belongsTo(Restaurant::class);
    }

    public function menuItem()
    {
        return $this->belongsTo(MenuItem::class);
    }
}
