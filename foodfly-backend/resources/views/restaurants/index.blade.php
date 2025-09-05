@extends('layouts.app')

@section('content')
    <div class="d-flex justify-content-between mb-3">
        <h2>Restaurants</h2>
        @auth
            <a href="{{ route('restaurants.create') }}" class="btn btn-primary">Add Restaurant</a>
        @endauth
    </div>

    <div class="row">
        @foreach ($restaurants as $restaurant)
            <div class="col-md-4 mb-3">
                <div class="card">
                    @if ($restaurant->image_url)
                        <img src="{{ asset($restaurant->image_url) }}" class="card-img-top" alt="{{ $restaurant->name }}"
                            width="200">
                    @endif
                    <div class="card-body">
                        <h5 class="card-title">{{ $restaurant->name }}</h5>
                        <p class="card-text">{{ $restaurant->address }}</p>
                        <a href="{{ route('restaurants.show', $restaurant->id) }}" class="btn btn-sm btn-primary">View
                            Menu</a>
                    </div>
                </div>
            </div>
        @endforeach
    </div>
@endsection
