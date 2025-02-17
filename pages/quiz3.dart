import 'package:flutter/material.dart';
import 'result.dart';

class QuizPage3 extends StatelessWidget {
  final double progress;
  final int score;
  final String currentLesson;
  final String courseName;

  QuizPage3({required this.progress, required this.score, required this.currentLesson, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 20,
                width: 227,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  color: Color.fromARGB(255, 188, 138, 179),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text("${(progress * 100).toInt()}%"),
            SizedBox(width: 10),
            Image.asset('assets/images/oxygen.png', width: 24, height: 24),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 237, 212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Quiz Page 3", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 600),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 188, 138, 179),
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Navigate to ResultPage with the required parameters
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      score: score,
                      currentLesson: currentLesson,
                      courseName: courseName,
                    ),
                  ),
                );
              },
              child: Text("Finish", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
