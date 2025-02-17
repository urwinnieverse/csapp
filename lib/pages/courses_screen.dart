import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'course_button.dart';
import 'Path.dart';
import 'bottom_navigation.dart';
import 'app_bar.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150),
            Text(
              "Courses",
              style: GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),

            // Basic Course Button
            CourseButton(
              imagePath: 'assets/images/basics.png',
              text: "Basic",
              borderColor: Color(0xFF3B7169),
              completionPercentage: 60,
              onGoToCourse: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pathscreen(
                      courseName: "Basic",
                      completionPercentage: 50,

                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            // Python Course Button
            CourseButton(
              imagePath: 'assets/images/python.png',
              text: "Python",
              borderColor: Color(0xFFFBBE64),
              completionPercentage: 20,
              onGoToCourse: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pathscreen(
                      courseName: "Python",
                      completionPercentage: 70,

                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
