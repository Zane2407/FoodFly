import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';
import 'auth/restaurant_screen.dart';
import '../widgets/restaurant_card.dart';

// Home Screen (updated with logout option)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Restaurant> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  Future<void> loadRestaurants() async {
    final data = await ApiService.getRestaurants();
    setState(() {
      restaurants = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FoodFly'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadRestaurants,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantScreen(restaurant: restaurant),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
