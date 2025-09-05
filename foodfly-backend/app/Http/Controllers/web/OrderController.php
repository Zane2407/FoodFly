<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class OrderController extends Controller
{
    private $apiUrl = 'http://127.0.0.1:8000/api';

    public function index()
    {
        $token = session('api_token');
        $orders = Http::withToken($token)->get($this->apiUrl . '/orders')->json();
        return view('orders.index', compact('orders'));
    }

    public function create()
    {
        $token = session('api_token');
        $restaurants = Http::withToken($token)->get($this->apiUrl . '/restaurants')->json();
        $menuItems = Http::withToken($token)->get($this->apiUrl . '/menu-items')->json() ?? [];
        return view('orders.create', compact('restaurants', 'menuItems'));
    }

    public function store(Request $request)
    {
        $token = session('api_token');
        $response = Http::withToken($token)->post($this->apiUrl . '/orders', $request->only('restaurant_id', 'menu_item_id', 'customer_name', 'customer_phone', 'customer_address', 'quantity', 'total_price'));

        if ($response->successful()) {
            return redirect()->route('orders.index')->with('success', 'Order created successfully');
        }

        return back()->withErrors($response->json('message'))->withInput();
    }
}
