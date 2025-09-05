import 'package:flutter/material.dart';
import 'package:foodfly/screens/splash_screen.dart';

void main() {
  runApp(const FoodFlyApp());
}

class FoodFlyApp extends StatelessWidget {
  const FoodFlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodFly',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
