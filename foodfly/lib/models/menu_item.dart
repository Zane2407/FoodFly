class MenuItem {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final bool isAvailable;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.isAvailable = true,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['image_url'],
      isAvailable: json['is_available'] ?? true,
    );
  }
}
