import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:code_space_project/pages/course_button.dart';
import 'package:code_space_project/pages/Path.dart';
import 'package:code_space_project/pages/bottom_navigation.dart';
import 'package:code_space_project/pages/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoursesScreen extends StatelessWidget {
  // Fetch courses from Firebase Firestore
  Future<List<Map<String, dynamic>>> fetchCourses() async {
    List<Map<String, dynamic>> courses = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .get();

      for (var doc in querySnapshot.docs) {
        courses.add({
          "name": doc['name'],
          "imagePath": doc['imagePath'],
          "borderColor": doc['borderColor'],
          "completionPercentage": doc['completionPercentage'],
        });
      }
    } catch (e) {
      print("Error fetching courses: $e");
    }
    return courses;
  }

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

            // Fetch and display courses dynamically
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchCourses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading courses"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No courses available"));
                }

                List<Map<String, dynamic>> courses = snapshot.data!;

                return Column(
                  children: courses.map((course) {
                    return Column(
                      children: [
                        CourseButton(
                          imagePath: course["imagePath"],
                          text: course["name"],
                          borderColor: Color(int.parse(course["borderColor"].replaceAll("#", "0xFF"))),
                          completionPercentage: course["completionPercentage"],
                          onGoToCourse: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pathscreen(
                                  courseName: course["name"],
                                  completionPercentage: course["completionPercentage"],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
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