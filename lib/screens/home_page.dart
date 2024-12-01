// home_page.dart
import 'package:flutter/material.dart';
import '../components/eventcard.dart'; // Import the SwipeableEvents widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Implement menu functionality here
          },
        ),
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_sharp),
            color: Colors.black,
            onPressed: () {
              // Implement notification functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.messenger_outline_outlined),
            color: Colors.black,
            onPressed: () {
              // Implement messenger functionality here
            },
          ),
        ],
      ),
      body:
          const SwipeableEvents(), // Replace the SingleChildScrollView with SwipeableEvents
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
