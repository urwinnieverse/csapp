import 'package:flutter/material.dart';
import 'friens_mood.dart'; // Import FriendsMoodScreen
import 'random_mood.dart';
import 'courses_screen.dart';
import 'app_bar.dart';
import 'bottom_navigation.dart';

class CompetitionScreen extends StatelessWidget {
  const CompetitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get the screen width

    return Scaffold(
      appBar: customAppBar(), // Your custom app bar
      backgroundColor: Colors.orange[50], // Background color
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Join Competition",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildCompetitionButton(
                context, "Alien Friends", "assets/images/Group42.png", screenWidth, isPopup: true),
            const SizedBox(height: 10),
            _buildCompetitionButton(
                context, "Random Aliens", "assets/images/Group43.png", screenWidth, isPopup: false),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(), // Add Bottom Navigation
    );
  }

  Widget _buildCompetitionButton(BuildContext context, String title, String imagePath, double screenWidth, {required bool isPopup}) {
    return GestureDetector(
      onTap: () {
        if (isPopup) {
          // Show FriendsMoodScreen as a floating window
          showDialog(
            context: context,
            barrierColor: Colors.transparent, // Removes black background
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent, // Ensure no black box
              child: SizedBox(
                width: screenWidth * 0.85, // 85% of screen width
                child: FriendsMoodScreen(),
              ),
            ),
          );
        }
      },
      child: Center(
        child: Container(
          width: screenWidth - 40, // Same width as screen minus padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 200, height: 190, fit: BoxFit.contain),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}