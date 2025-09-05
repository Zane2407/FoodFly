import 'menu_item.dart';

class Restaurant {
  final int id;
  final String name;
  final String address;
  final String phone;
  final double rating;
  final String? imageUrl;
  final List<MenuItem> menuItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.rating,
    this.imageUrl,
    this.menuItems = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      rating: double.parse(json['rating'].toString()),
      imageUrl: json['image_url'],
      menuItems: json['menu_items'] != null
          ? (json['menu_items'] as List)
              .map((item) => MenuItem.fromJson(item))
              .toList()
          : [],
    );
  }
}
