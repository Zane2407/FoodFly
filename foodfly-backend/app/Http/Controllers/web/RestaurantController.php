<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class RestaurantController extends Controller
{
    private $apiUrl = 'http://127.0.0.1:8000/api';

    public function index()
    {
        $restaurants = Http::get($this->apiUrl . '/restaurants')->json();
        return view('restaurants.index', compact('restaurants'));
    }

    public function show($id)
    {
        $restaurant = Http::get($this->apiUrl . "/restaurants/{$id}")->json();
        return view('restaurants.show', compact('restaurant'));
    }

    public function create()
    {
        return view('restaurants.create');
    }

    public function store(Request $request)
    {
        $token = session('api_token');
        $response = Http::withToken($token)->post($this->apiUrl . '/restaurants', $request->only('name', 'address', 'phone', 'rating', 'image_url'));

        if ($response->successful()) {
            return redirect()->route('restaurants.index')->with('success', 'Restaurant added successfully');
        }

        return back()->withErrors($response->json('message'))->withInput();
    }
}
