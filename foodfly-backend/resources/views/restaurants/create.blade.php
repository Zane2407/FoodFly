@extends('layouts.app')

@section('content')
    <h2>Add Restaurant</h2>
    <form method="POST" action="{{ route('restaurants.store') }}" enctype="multipart/form-data">
        @csrf
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" class="form-control" value="{{ old('name') }}">
            @error('name')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Address</label>
            <input type="text" name="address" class="form-control" value="{{ old('address') }}">
            @error('address')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control" value="{{ old('phone') }}">
            @error('phone')
                <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>
        <div class="mb-3">
            <label>Rating</label>
            <input type="number" step="0.1" name="rating" class="form-control" value="{{ old('rating') }}">
            @error('rating')
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
