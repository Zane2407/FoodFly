<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::with(['restaurant', 'menuItem'])->get();
        return response()->json($orders);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'restaurant_id' => 'required|exists:restaurants,id',
            'menu_item_id' => 'required|exists:menu_items,id',
            'customer_name' => 'required|string|max:255',
            'customer_phone' => 'required|string|max:20',
            'customer_address' => 'required|string',
            'quantity' => 'required|integer|min:1',
            'total_price' => 'required|numeric|min:0'
        ]);

        $order = Order::create($validated);
        return response()->json($order->load(['restaurant', 'menuItem']), 201);
    }

    public function updateStatus(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:pending,confirmed,preparing,delivered'
        ]);

        $order = Order::findOrFail($id);
        $order->update($validated);

        return response()->json($order->load(['restaurant', 'menuItem']));
    }
}
