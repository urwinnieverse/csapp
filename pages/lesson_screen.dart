import 'package:flutter/material.dart';
import 'quiz1.dart';

class LessonScreen extends StatefulWidget {
  final String lessonTitle;
  final String courseName;

  LessonScreen({required this.lessonTitle, required this.courseName});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [];

    if (widget.courseName == "Basic" && widget.lessonTitle == "Lesson 1") {
      pages = [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Basics: Lesson 1 - Introduction",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to the basics! In this lesson, we will cover fundamental concepts that will help you understand the course structure.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/basics_intro.png', height: 200),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Basics: Lesson 1 - Key Concepts",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Key Concepts in Basics:\n\n"
                  "1️⃣ Understanding the User Interface (UI)\n"
                  "2️⃣ Basic Navigation in the App\n"
                  "3️⃣ Interacting with Elements\n"
                  "4️⃣ The Importance of Consistency in Design",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage1(
                      courseName: widget.courseName,
                      currentLesson: widget.lessonTitle,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text("Go to Quiz"),
            ),
          ],
        ),
      ];
    } else if (widget.courseName == "Basic" && widget.lessonTitle == "Lesson 2") {
      pages = [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Basics: Lesson 2 - UI Design",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ];
    } else if (widget.courseName == "Python" && widget.lessonTitle == "Lesson 1") {
      pages = [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Python: Lesson 1 - Introduction",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Python: Lesson 1 - Variables",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ];
    } else if (widget.courseName == "Python" && widget.lessonTitle == "Lesson 2") {
      pages = [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Python: Lesson 2 - Data Types",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ];
    } else {
      pages = [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Content not available",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ];
    }

    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text(widget.lessonTitle),
        backgroundColor: Colors.orange[50],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: pages[currentPage],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentPage > 0)
                TextButton(
                  onPressed: () => setState(() => currentPage--),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFBC8AB3),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(310, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),

                    ),
                  ),
                  child: const Text('Back'),
                ),
              if (currentPage < pages.length - 1)
                TextButton(
                  onPressed: () => setState(() => currentPage++),
                   style: TextButton.styleFrom(
                       backgroundColor: Color(0xFFBC8AB3),
                         foregroundColor: Colors.white,
                       fixedSize: const Size(310, 50),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),

    ),
    ),
    child: const Text('Next'),
    ),
            ],
          ),
        ],
      ),
    );
  }
}
