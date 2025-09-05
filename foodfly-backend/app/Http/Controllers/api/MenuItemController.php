<?php


namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\MenuItem;
use Illuminate\Http\Request;

class MenuItemController extends Controller
{
    public function index($restaurant_id)
    {
        $menuItems = MenuItem::where('restaurant_id', $restaurant_id)
            ->where('is_available', true)
            ->get();
        return response()->json($menuItems);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'restaurant_id' => 'required|exists:restaurants,id',
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric|min:0',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048'
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('menu_images', 'public');
            $validated['image_url'] = '/storage/' . $imagePath;
        }

        $menuItem = MenuItem::create($validated);
        return response()->json($menuItem, 201);
    }
}
