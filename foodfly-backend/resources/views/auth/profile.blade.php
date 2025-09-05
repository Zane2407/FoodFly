<!-- Profile Page -->
@extends('layouts.app')
@section('content')
    <div class="container">
        <h2>Profile</h2>
        <div class="card">
            <div class="card-body">
                <p><strong>Name:</strong> {{ Auth::user()->name }}</p>
                <p><strong>Email:</strong> {{ Auth::user()->email }}</p>
                <a href="{{ route('logout') }}" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
@endsection
