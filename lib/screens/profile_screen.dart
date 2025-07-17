import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile header
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Chef Master',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Cooking enthusiast',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            
            // Stats cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Recipes Cooked', '23', Icons.restaurant),
                _buildStatCard('Favorites', '12', Icons.favorite),
                _buildStatCard('Shopping Lists', '5', Icons.shopping_cart),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Settings options
            _buildSettingsItem(
              'Dietary Preferences',
              Icons.local_dining,
              () {},
            ),
            _buildSettingsItem(
              'Notification Settings',
              Icons.notifications,
              () {},
            ),
            _buildSettingsItem(
              'Units (Metric/Imperial)',
              Icons.straighten,
              () {},
            ),
            _buildSettingsItem(
              'About',
              Icons.info,
              () {},
            ),
            _buildSettingsItem(
              'Sign Out',
              Icons.exit_to_app,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.orange[600]),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange[600]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}