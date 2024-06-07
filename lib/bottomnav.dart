import 'package:flutter/material.dart';
import 'package:uaspm/views/history.dart';
import 'package:uaspm/views/home_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0; // Current selected tab index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(), // Display the corresponding body based on the selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // Handle tab tap events
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    // Display the corresponding body based on the selected tab index
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return HistoryPage();
      default:
        return Container(); // Handle additional tabs if needed
    }
  }

  void _onTabTapped(int index) {
    // Update the current selected tab index
    setState(() {
      _currentIndex = index;
    });
  }
}