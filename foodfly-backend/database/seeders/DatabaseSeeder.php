<?php
// database/seeders/DatabaseSeeder.php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Restaurant;
use App\Models\MenuItem;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        // Create restaurants
        $restaurants = [
            [
                'name' => 'Pizza Palace',
                'address' => '123 Main St, City Center',
                'phone' => '+1-555-0123',
                'rating' => 4.5,
                'image_url' => 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop'
            ],
            [
                'name' => 'Burger Barn',
                'address' => '456 Oak Ave, Downtown',
                'phone' => '+1-555-0456',
                'rating' => 4.2,
                'image_url' => 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop'
            ],
            [
                'name' => 'Asian Fusion',
                'address' => '789 Pine Rd, Uptown',
                'phone' => '+1-555-0789',
                'rating' => 4.7,
                'image_url' => 'https://images.unsplash.com/photo-1617196034183-421b4917abd8?w=400&h=300&fit=crop'
            ]
        ];

        foreach ($restaurants as $restaurantData) {
            $restaurant = Restaurant::create($restaurantData);

            // Create menu items for each restaurant
            if ($restaurant->name === 'Pizza Palace') {
                $menuItems = [
                    ['name' => 'Margherita Pizza', 'description' => 'Classic tomato, mozzarella, and basil', 'price' => 14.99],
                    ['name' => 'Pepperoni Pizza', 'description' => 'Pepperoni with mozzarella cheese', 'price' => 16.99],
                    ['name' => 'Supreme Pizza', 'description' => 'Loaded with pepperoni, sausage, peppers, onions', 'price' => 19.99],
                ];
            } elseif ($restaurant->name === 'Burger Barn') {
                $menuItems = [
                    ['name' => 'Classic Burger', 'description' => 'Beef patty with lettuce, tomato, onion', 'price' => 12.99],
                    ['name' => 'Bacon Cheeseburger', 'description' => 'Beef patty with bacon and cheese', 'price' => 15.99],
                    ['name' => 'Veggie Burger', 'description' => 'Plant-based patty with fresh vegetables', 'price' => 13.99],
                ];
            } else {
                $menuItems = [
                    ['name' => 'Pad Thai', 'description' => 'Stir-fried rice noodles with shrimp', 'price' => 13.99],
                    ['name' => 'Chicken Teriyaki', 'description' => 'Grilled chicken with teriyaki sauce', 'price' => 16.99],
                    ['name' => 'Vegetable Fried Rice', 'description' => 'Wok-fried rice with mixed vegetables', 'price' => 11.99],
                ];
            }

            foreach ($menuItems as $itemData) {
                MenuItem::create([
                    'restaurant_id' => $restaurant->id,
                    'name' => $itemData['name'],
                    'description' => $itemData['description'],
                    'price' => $itemData['price'],
                    'image_url' => 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300&h=200&fit=crop',
                    'is_available' => true
                ]);
            }
        }
    }
}
