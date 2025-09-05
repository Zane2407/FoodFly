<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class MenuItemController extends Controller
{
    private $apiUrl = 'http://127.0.0.1:8000/api';

    public function create()
    {
        $restaurants = Http::withToken(session('api_token'))->get($this->apiUrl . '/restaurants')->json();
        return view('menu-items.create', compact('restaurants'));
    }

    public function store(Request $request)
    {
        $token = session('api_token');
        $response = Http::withToken($token)->post($this->apiUrl . '/menu-items', $request->only('restaurant_id', 'name', 'description', 'price', 'image_url'));

        if ($response->successful()) {
            return redirect()->route('restaurants.index')->with('success', 'Menu item added successfully');
        }

        return back()->withErrors($response->json('message'))->withInput();
    }
}
