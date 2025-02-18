import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'courses_screen.dart';  // Update with your main screen
import 'package:code_space_project/pages/login.dart';   // Update with your login screen

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CoursesScreen(); // If logged in, go to main screen// the navigation that i deleted from login is here//
        } else {
          return LoginScreen(); // If not logged in, show login screen
        }
      },
    );
  }
}
