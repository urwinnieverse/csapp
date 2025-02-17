import 'package:flutter/material.dart';
import 'lesson_screen.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final String currentLesson;
  final String courseName;

  ResultPage({required this.score, required this.currentLesson, required this.courseName});

  // Function to calculate XP based on the score
  int calculateXp() {
    return score == 3 ? 100 : 0; // Award 100 XP if all answers are correct
  }

  // Function to get the next lesson title
  String? getNextLesson() {
    Map<String, List<String>> courseLessons = {
      "Basic": ["Lesson 1", "Lesson 2"],
      "Python": ["Lesson 1", "Lesson 2"],
    };

    List<String>? lessons = courseLessons[courseName];
    if (lessons != null) {
      int currentIndex = lessons.indexOf(currentLesson);
      if (currentIndex != -1 && currentIndex < lessons.length - 1) {
        return lessons[currentIndex + 1]; // Get next lesson
      }
    }
    return null; // No next lesson available
  }

  @override
  Widget build(BuildContext context) {
    final int xp = calculateXp();
    final String? nextLesson = getNextLesson();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Result"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 237, 212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 270),
            Divider(color: Colors.grey, thickness: 2, indent: 20, endIndent: 20),
            SizedBox(height: 10),

            Text("Perfect lesson", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            Text("Good job!", style: TextStyle(fontSize: 18)),
            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildInfoContainer("Total XP", "$xp", Colors.red),
                buildInfoContainer("Final Score", "$score / 3", Colors.green),
                buildInfoContainer("Level", "1", Colors.blue),
              ],
            ),
            SizedBox(height: 100),

            // Retake Quiz Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 188, 138, 179),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Retake Quiz", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),

            SizedBox(height: 20),

            // "Go to Next Lesson" Button
            if (nextLesson != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonScreen(
                        lessonTitle: nextLesson,
                        courseName: courseName,
                      ),
                    ),
                  );
                },
                child: Text("Go to Next Lesson", style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  // Widget for reusable info containers
  Widget buildInfoContainer(String title, String value, Color color) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ),
        ],
      ),
    );
  }
}
