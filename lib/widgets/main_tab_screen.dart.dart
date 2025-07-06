import 'package:flutter/material.dart';
import 'package:foodio/screens/profile/profile_screen.dart';
import 'package:foodio/screens/home/home_screen.dart';

class MainTabScreen extends StatefulWidget {
  static const String route = '/home';

  const MainTabScreen({super.key});

  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    Placeholder(),
    Placeholder(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildNavItem(IconData iconData, int index) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(
          iconData,
          color: _currentIndex == index ? Colors.black : Colors.grey,
          size: 28,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_rounded, 0),
            _buildNavItem(Icons.search_rounded, 1),
            _buildNavItem(Icons.shopping_bag_rounded, 2),
            _buildNavItem(Icons.person_rounded, 3),
          ],
        ),
      ),
    );
  }
}