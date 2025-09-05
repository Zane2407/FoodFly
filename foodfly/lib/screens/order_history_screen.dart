import 'package:flutter/material.dart';
import 'package:foodfly/services/api_service.dart';
import 'package:foodfly/services/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Order History Screen
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<dynamic> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/orders'),
        headers: AuthService.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          orders = data;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No orders yet',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order['restaurant']['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(order['status']),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    order['status'].toString().toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(order['menu_item']['name']),
                            const SizedBox(height: 4),
                            Text('Quantity: ${order['quantity']}'),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${double.parse(order['total_price'].toString()).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.orange[600],
                                  ),
                                ),
                                Text(
                                  DateTime.parse(order['created_at'])
                                      .toString()
                                      .split('.')[0],
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'preparing':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
