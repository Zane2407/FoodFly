import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

// Auth Service
class AuthService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  static User? _currentUser;
  static String? _token;

  static User? get currentUser => _currentUser;
  static String? get token => _token;
  static bool get isLoggedIn => _token != null;

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    final userJson = prefs.getString('user_data');
    if (userJson != null) {
      _currentUser = User.fromJson(json.decode(userJson));
    }
  }

  static Future<void> saveToken(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_data', json.encode(user.toJson()));
    _token = token;
    _currentUser = user;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    _token = null;
    _currentUser = null;
  }

  static Map<String, String> get headers {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
    String? address,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'phone': phone,
          'address': address,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201 && data['success']) {
        final user = User.fromJson(data['user']);
        await saveToken(data['token'], user);
      }

      return data;
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success']) {
        final user = User.fromJson(data['user']);
        await saveToken(data['token'], user);
      }

      return data;
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<bool> logout() async {
    try {
      if (_token != null) {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: headers,
        );
      }
      await clearToken();
      return true;
    } catch (e) {
      await clearToken();
      return false;
    }
  }
}
