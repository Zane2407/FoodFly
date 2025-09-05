<?php
// routes/api.php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\RestaurantController;
use App\Http\Controllers\Api\MenuItemController;
use App\Http\Controllers\Api\OrderController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::apiResource('restaurants', RestaurantController::class);
Route::apiResource('menu-items', MenuItemController::class);
Route::apiResource('orders', OrderController::class);
// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Public restaurant and menu routes
Route::get('/restaurants', [RestaurantController::class, 'index']);
Route::get('/restaurants/{id}', [RestaurantController::class, 'show']);
Route::get('/restaurants/{restaurant_id}/menu-items', [MenuItemController::class, 'index']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Auth routes
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [AuthController::class, 'profile']);
    Route::put('/profile', [AuthController::class, 'updateProfile']);

    // Order routes (require authentication)
    Route::get('/orders', [OrderController::class, 'index']);
    Route::post('/orders', [OrderController::class, 'store']);
    Route::put('/orders/{id}/status', [OrderController::class, 'updateStatus']);

    // Admin routes (for creating restaurants and menu items)
    Route::post('/restaurants', [RestaurantController::class, 'store']);
    Route::post('/menu-items', [MenuItemController::class, 'store']);
});
