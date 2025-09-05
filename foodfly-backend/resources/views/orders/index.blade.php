@extends('layouts.app')

@section('content')
    <h2>Orders</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Customer</th>
                <th>Restaurant</th>
                <th>Menu Item</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($orders as $order)
                <tr>
                    <td>{{ $order->customer_name }}</td>
                    <td>{{ $order->restaurant->name }}</td>
                    <td>{{ $order->menuItem->name }}</td>
                    <td>{{ $order->quantity }}</td>
                    <td>${{ $order->total_price }}</td>
                    <td>{{ ucfirst($order->status) }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
@endsection
