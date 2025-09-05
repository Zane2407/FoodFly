import 'package:flutter/material.dart';
import 'package:foodfly/models/restaurant.dart';
import 'package:foodfly/models/menu_item.dart';
import 'package:foodfly/services/api_service.dart';
import 'package:foodfly/widgets/menu_item_card.dart';

// Restaurant Screen
class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  List<MenuItem> menuItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMenuItems();
  }

  Future<void> loadMenuItems() async {
    final data = await ApiService.getMenuItems(widget.restaurant.id);
    setState(() {
      menuItems = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Restaurant Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      widget.restaurant.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(widget.restaurant.phone),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.restaurant.address,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return MenuItemCard(
                        menuItem: item,
                        restaurant: widget.restaurant,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
