<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Restaurant;
use Illuminate\Http\Request;

class RestaurantController extends Controller
{
    public function index()
    {
        $restaurants = Restaurant::with('menuItems')->get();
        return response()->json($restaurants);
    }

    public function show($id)
    {
        $restaurant = Restaurant::with('menuItems')->findOrFail($id);
        return response()->json($restaurant);
    }

    public function store(Request $request)
    {

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'required|string',
            'phone' => 'required|string|max:20',
            'rating' => 'numeric|between:0,5',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048'
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('restaurant_images', 'public');
            $validated['image_url'] = '/storage/' . $imagePath;
        }

        $restaurant = Restaurant::create($validated);
        return response()->json($restaurant, 201);
    }
}
