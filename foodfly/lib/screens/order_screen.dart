import 'package:flutter/material.dart';
import 'package:foodfly/models/menu_item.dart';
import 'package:foodfly/models/restaurant.dart';
import 'package:foodfly/models/order.dart';
import 'package:foodfly/services/api_service.dart';
import 'package:foodfly/services/auth_service.dart';

// Order Screen
class OrderScreen extends StatefulWidget {
  final MenuItem menuItem;
  final Restaurant restaurant;

  const OrderScreen({
    Key? key,
    required this.menuItem,
    required this.restaurant,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  int quantity = 1;
  bool isPlacingOrder = false;

  double get totalPrice => widget.menuItem.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Summary
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.restaurant.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.menuItem.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(widget.menuItem.description),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Text(
                                  'Quantity:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: quantity > 1
                                      ? () => setState(() => quantity--)
                                      : null,
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => setState(() => quantity++),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\${totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Customer Information
                    const Text(
                      'Delivery Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Delivery Address',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your delivery address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Place Order Button
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isPlacingOrder ? null : _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                  ),
                  child: isPlacingOrder
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Place Order - \${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isPlacingOrder = true;
    });

    // Use user's profile data if available, otherwise use form data
    final user = AuthService.currentUser;
    final order = Order(
      restaurantId: widget.restaurant.id,
      menuItemId: widget.menuItem.id,
      customerName: user?.name ?? _nameController.text,
      customerPhone: user?.phone ?? _phoneController.text,
      customerAddress: user?.address ?? _addressController.text,
      quantity: quantity,
      totalPrice: totalPrice,
    );

    final success = await ApiService.placeOrder(order);

    setState(() {
      isPlacingOrder = false;
    });

    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Placed!'),
          content: const Text(
              'Your order has been placed successfully. We will contact you soon.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to restaurant screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to place order. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Pre-fill form with user data if available
    final user = AuthService.currentUser;
    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phone ?? '';
      _addressController.text = user.address ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
