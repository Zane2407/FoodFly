@extends('layouts.app')

@section('content')
    <h2>Create Order</h2>
    <form method="POST" action="{{ route('orders.store') }}">
        @csrf
        <div class="mb-3">
            <label>Restaurant</label>
            <select name="restaurant_id" class="form-control">
                @foreach ($restaurants as $restaurant)
                    <option value="{{ $restaurant->id }}">{{ $restaurant->name }}</option>
                @endforeach
            </select>
            @error('restaurant_id')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Menu Item</label>
            <select name="menu_item_id" class="form-control">
                @foreach ($menuItems as $item)
                    <option value="{{ $item->id }}">{{ $item->name }}</option>
                @endforeach
            </select>
            @error('menu_item_id')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Customer Name</label>
            <input type="text" name="customer_name" class="form-control">
        </div>
        <div class="mb-3">
            <label>Customer Phone</label>
            <input type="text" name="customer_phone" class="form-control">
        </div>
        <div class="mb-3">
            <label>Customer Address</label>
            <input type="text" name="customer_address" class="form-control">
        </div>
        <div class="mb-3">
            <label>Quantity</label>
            <input type="number" name="quantity" class="form-control" value="1">
        </div>
        <div class="mb-3">
            <label>Total Price</label>
            <input type="number" step="0.01" name="total_price" class="form-control">
        </div>
        <button class="btn btn-primary">Place Order</button>
    </form>
@endsection
