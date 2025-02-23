import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz2.dart';
import 'draggableQuiz.dart';

class QuizPage1 extends StatefulWidget {
  final double progress;
  final String currentLesson;
  final String courseName;

  QuizPage1({Key? key, this.progress = 0.4, required this.currentLesson, required this.courseName}) : super(key: key);

  @override
  _QuizPage1State createState() => _QuizPage1State();
}

class _QuizPage1State extends State<QuizPage1> {
  double progress = 0.33;
  Map<int, String?> selectedAnswers = {};
  List<String> correctAnswers = [];
  List<String> draggableOptions = [];
  List<Map<String, String>> questions = [];
  int score = 0;

  // Fetch quiz data from Firebase Firestore
  Future<void> fetchQuizData() async {
    try {
      DocumentSnapshot quizSnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseName)
          .collection('lessons')
          .doc(widget.currentLesson)
          .collection('quizzes')
          .doc('quiz1') // Assuming the quiz ID is 'quiz1'
          .get();

      if (quizSnapshot.exists) {
        setState(() {
          correctAnswers = List<String>.from(quizSnapshot['correctAnswers']);
          draggableOptions = List<String>.from(quizSnapshot['draggableOptions']);
          questions = List<Map<String, String>>.from(quizSnapshot['questions']);
          selectedAnswers = Map<int, String?>.fromIterable(
            List.generate(questions.length, (index) => index),
            key: (index) => index,
            value: (index) => null,
          );
        });
      }
    } catch (e) {
      print("Error fetching quiz data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

  void checkAnswers() {
    score = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) {
        score++;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage2(
          progress: widget.progress + 0.2,
          score: score,
          currentLesson: widget.currentLesson,
          courseName: widget.courseName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 20,
                width: 225,
                child: LinearProgressIndicator(
                  value: widget.progress,
                  backgroundColor: Colors.grey[300],
                  color: Color.fromARGB(255, 188, 138, 179),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text("${(widget.progress * 100).toInt()}%"),
            SizedBox(width: 10),
            Image.asset('assets/images/oxygen-tank1.png', width: 24, height: 24),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.orange[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/robot.png', width: 40),
                ),
                Text(
                  "Fill the following code with the appropriate answer:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                if (questions.isNotEmpty)
                  ...questions.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Column(
                      children: [
                        buildQuestion(index, entry.value['before']!, entry.value['after']!),
                        SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
              ],
            ),
          ),
          SizedBox(height: 60),
          if (draggableOptions.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: draggableOptions.map((option) {
                return Row(
                  children: [
                    DraggableAnswer(
                      text: option,
                      outerColor: _getOuterColor(option),
                      innerColor: _getInnerColor(option),
                    ),
                    SizedBox(width: 20),
                  ],
                );
              }).toList(),
            ),
          SizedBox(height: 125),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 188, 138, 179),
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (selectedAnswers.containsValue(null)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Complete all answers first!")),
                );
                return;
              }
              checkAnswers();
            },
            child: Text("CHECK", style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(int index, String before, String after) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: before,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              children: [
                WidgetSpan(
                  child: DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Center(
                          child: Text(selectedAnswers[index] ?? ""),
                        ),
                      );
                    },
                    onAccept: (data) {
                      setState(() {
                        selectedAnswers[index] = data;
                      });
                    },
                  ),
                ),
                TextSpan(
                  text: after,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper methods to get colors for draggable options
  Color _getOuterColor(String option) {
    switch (option) {
      case "=":
        return Color(0xFFD54032);
      case ">":
        return Color(0xFF3B7169);
      case "<":
        return Color(0xFFFBBE64);
      default:
        return Colors.grey;
    }
  }

  Color _getInnerColor(String option) {
    switch (option) {
      case "=":
        return Color(0xFFFFA198);
      case ">":
        return Color(0xFF83C1B8);
      case "<":
        return Color(0xFFFCD192);
      default:
        return Colors.grey;
    }
  }
}