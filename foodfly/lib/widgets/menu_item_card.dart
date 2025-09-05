import 'package:flutter/material.dart';
import 'package:foodfly/models/restaurant.dart';
import 'package:foodfly/models/menu_item.dart';
import 'package:foodfly/screens/order_screen.dart';

// Menu Item Card Widget
class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final Restaurant restaurant;

  const MenuItemCard({
    Key? key,
    required this.menuItem,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: menuItem.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        menuItem.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.fastfood, color: Colors.grey[600]);
                        },
                      ),
                    )
                  : Icon(Icons.fastfood, color: Colors.grey[600]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItem.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    menuItem.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${menuItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[600],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(
                      menuItem: menuItem,
                      restaurant: restaurant,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Order'),
            ),
          ],
        ),
      ),
    );
  }
}
