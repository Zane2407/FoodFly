<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    private $apiUrl = 'http://127.0.0.1:8000/api';

    public function showLoginForm()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $response = Http::post($this->apiUrl . '/login', $request->only('email', 'password'));

        if ($response->successful()) {
            $data = $response->json();
            session(['api_token' => $data['token']]);
            return redirect()->route('restaurants.index');
        }

        return back()->withErrors(['email' => 'Invalid credentials'])->withInput();
    }

    public function showRegisterForm()
    {
        return view('auth.register');
    }

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email',
            'password' => 'required|confirmed|min:6',
        ]);

        $response = Http::post($this->apiUrl . '/register', [
            'name' => $request->name,
            'email' => $request->email,
            'password' => $request->password,
            'password_confirmation' => $request->password_confirmation,
        ]);

        if ($response->successful()) {
            $data = $response->json();
            session(['api_token' => $data['token']]);
            return redirect()->route('restaurants.index');
        }

        return back()->withErrors($response->json('message'))->withInput();
    }

    public function logout()
    {
        $token = session('api_token');
        if ($token) {
            Http::withToken($token)->post($this->apiUrl . '/logout');
        }
        session()->forget('api_token');
        return redirect()->route('login');
    }

    public function profile()
    {
        $token = session('api_token');
        $response = Http::withToken($token)->get($this->apiUrl . '/profile');
        $user = $response->json('user');
        return view('auth.profile', compact('user'));
    }
}
