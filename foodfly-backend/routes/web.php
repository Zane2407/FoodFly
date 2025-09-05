<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\AuthController;
use App\Http\Controllers\Web\RestaurantController;
use App\Http\Controllers\Web\MenuItemController;
use App\Http\Controllers\Web\OrderController;

Route::get('/', [RestaurantController::class, 'index'])->name('restaurants.index');

Route::get('login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('login', [AuthController::class, 'login']);
Route::get('register', [AuthController::class, 'showRegisterForm'])->name('register');
Route::post('register', [AuthController::class, 'register']);
Route::post('logout', [AuthController::class, 'logout'])->name('logout');

Route::middleware('auth')->group(function () {
    Route::get('profile', [AuthController::class, 'profile'])->name('profile');

    Route::get('restaurants/create', [RestaurantController::class, 'create'])->name('restaurants.create');
    Route::post('restaurants', [RestaurantController::class, 'store'])->name('restaurants.store');
    Route::get('restaurants/{id}', [RestaurantController::class, 'show'])->name('restaurants.show');

    Route::get('menu-items/create', [MenuItemController::class, 'create'])->name('menu-items.create');
    Route::post('menu-items', [MenuItemController::class, 'store'])->name('menu-items.store');

    Route::get('orders', [OrderController::class, 'index'])->name('orders.index');
    Route::get('orders/create', [OrderController::class, 'create'])->name('orders.create');
    Route::post('orders', [OrderController::class, 'store'])->name('orders.store');
});
