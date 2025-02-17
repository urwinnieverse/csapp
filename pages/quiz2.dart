import 'package:flutter/material.dart';
import 'courses_screen.dart';
import 'quiz3.dart';
import 'Path.dart';

class QuizPage2 extends StatefulWidget {
  final double progress;
  final int score;
  final String currentLesson;
  final String courseName;

  QuizPage2({
    required this.progress,
    required this.score,
    required this.currentLesson,
    required this.courseName,
  });

  @override
  _QuizPage2State createState() => _QuizPage2State();
}

class _QuizPage2State extends State<QuizPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CoursesScreen()),
                );
              },
              child: Image.asset('assets/images/back.png', width: 25),
            ),
            SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 20,
                width: 227,
                child: LinearProgressIndicator(
                  value: widget.progress,
                  backgroundColor: Colors.grey[300],
                  color: Color.fromARGB(255, 188, 138, 179),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text("${(widget.progress * 100).toInt()}%"),
            SizedBox(width: 15),
            Image.asset('assets/images/oxygen-tank1.png', width: 24, height: 24),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 237, 212),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/robot.png', width: 40),
            ),
            SizedBox(height: 10),
            const Text(
              'What is the output of the following code snippet: \n\n print("Hello")?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),

            // First Row of Answer Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                answerButton("Hi", Color(0xFF83C1B8), Color(0xFF0E5C70)),
                const SizedBox(width: 20),
                answerButton("Hello", Color(0xFFFFA198), Color(0xFFD54032)),
              ],
            ),

            const SizedBox(height: 20),

            // Second Row of Answer Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                answerButton('"Hello"', Color(0xFFFCD192), Color(0xFFFBBE64)),
                const SizedBox(width: 20),
                answerButton('"Hi"', Color(0xFF68A6B6), Color(0xFF3B7169)),
              ],
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 188, 138, 179),
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage3(
                      progress: widget.progress + 0.4,
                      score: widget.score,
                      currentLesson: widget.currentLesson,
                      courseName: widget.courseName,
                    ),
                  ),
                );
              },
              child: Text("CHECK", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Answer Button
  Widget answerButton(String text, Color color, Color borderColor) {
    return TextButton(
      onPressed: () => checkAnswer(text),
      style: TextButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        fixedSize: const Size(150, 150),
        side: BorderSide(color: borderColor, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 28)),
    );
  }

  void checkAnswer(String selectedAnswer) {
    // Logic to check if the selected answer is correct
    // You can implement feedback or scoring here
  }
}
