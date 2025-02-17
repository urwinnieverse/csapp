import 'package:flutter/material.dart';
import 'Competition.dart';
import 'courses_screen.dart';
import 'profile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // Function to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the respective screen
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoursesScreen()), // Navigate to CoursesScreen
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompetitionScreen()), // Navigate to CompetitionScreen
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to CompetitionScreen
        );
        break;
    // You can add more cases for other icons if needed
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped, // When an item is tapped, call _onItemTapped
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/courses.png', width: 30, height: 30),
          label: "Courses",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/competition.png', width: 45, height: 30),
          label: "Competition",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/alien1.png', width: 30, height: 30),
          label: "Profile",
        ),
      ],
    );
  }
}
