@extends('layouts.app')

@section('content')
    <h2>{{ $restaurant->name }}</h2>
    <p>{{ $restaurant->address }}</p>

    <h4>Menu Items</h4>
    <div class="row">
        @foreach ($restaurant->menuItems as $item)
            <div class="col-md-4 mb-3">
                <div class="card">
                    @if ($item->image_url)
                        <img src="{{ asset($item->image_url) }}" class="card-img-top" alt="{{ $item->name }}" width="200">
                    @endif
                    <div class="card-body">
                        <h5>{{ $item->name }}</h5>
                        <p>{{ $item->description }}</p>
                        <p><strong>${{ $item->price }}</strong></p>
                    </div>
                </div>
            </div>
        @endforeach
    </div>
@endsection
