import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';
import '../models/menu_item.dart';
import '../models/order.dart';
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/restaurants'),
        headers: AuthService.headers,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
      return [];
    }
  }

  static Future<List<MenuItem>> getMenuItems(int restaurantId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/restaurants/$restaurantId/menu-items'),
        headers: AuthService.headers,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => MenuItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load menu items');
      }
    } catch (e) {
      print('Error fetching menu items: $e');
      return [];
    }
  }

  static Future<bool> placeOrder(Order order) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: AuthService.headers,
        body: json.encode(order.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error placing order: $e');
      return false;
    }
  }
}
