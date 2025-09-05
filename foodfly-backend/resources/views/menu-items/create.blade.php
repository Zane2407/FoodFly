@extends('layouts.app')

@section('content')
    <h2>Add Menu Item</h2>
    <form method="POST" action="{{ route('menu-items.store') }}" enctype="multipart/form-data">
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
            <label>Name</label>
            <input type="text" name="name" class="form-control" value="{{ old('name') }}">
            @error('name')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control">{{ old('description') }}</textarea>
            @error('description')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Price</label>
            <input type="number" step="0.01" name="price" class="form-control" value="{{ old('price') }}">
            @error('price')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Image</label>
            <input type="file" name="image" class="form-control">
            @error('image')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <button class="btn btn-primary">Save</button>
    </form>
@endsection
