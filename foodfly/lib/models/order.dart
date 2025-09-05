class Order {
  final int? id;
  final int restaurantId;
  final int menuItemId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final int quantity;
  final double totalPrice;
  final String status;

  Order({
    this.id,
    required this.restaurantId,
    required this.menuItemId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.quantity,
    required this.totalPrice,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurantId,
      'menu_item_id': menuItemId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_address': customerAddress,
      'quantity': quantity,
      'total_price': totalPrice,
    };
  }
}
