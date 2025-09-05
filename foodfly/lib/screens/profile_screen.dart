import 'package:flutter/material.dart';
import 'package:foodfly/screens/auth/login_screen.dart';
import 'package:foodfly/services/auth_service.dart';

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.orange[100],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.orange[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.name ?? 'User',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user?.email ?? '',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    if (user?.phone != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        user!.phone!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                    if (user?.address != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        user!.address!,
                        style: TextStyle(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await AuthService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
