import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_space_project/pages/compresult.dart';

class QuizScreen extends StatefulWidget {
  final String quizId; // Pass quizId to fetch specific quiz data

  const QuizScreen({super.key, required this.quizId});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextEditingController textEditingController = TextEditingController();
  int _seconds = 0; // Initialize to 0, will be updated from Firestore
  Timer? _timer;
  List<Map<String, dynamic>> questions = []; // List of questions
  int currentQuestionIndex = 0; // Track the current question
  bool isLoading = true;
  String errorMessage = "";
  String? selectedAnswer; // Track the user's selected answer
  bool isAnswerCorrect = false; // Track if the selected answer is correct

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

// Fetch quiz data from Firebase Firestore
  Future<void> fetchQuizData() async {
    try {
      // Fetch the quiz document to get the timer duration
      DocumentSnapshot quizSnapshot = await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(widget.quizId)
          .get();

      if (quizSnapshot.exists) {
        // Fetch the timer duration from the quiz document
        int timerDuration = quizSnapshot['timerDuration']; // Ensure this field exists in Firestore

        // Fetch the questions for this quiz
        QuerySnapshot questionsSnapshot = await FirebaseFirestore.instance
            .collection('quizzes')
            .doc(widget.quizId)
            .collection('questions')
            .get();

        if (questionsSnapshot.docs.isNotEmpty) {
          setState(() {
            questions = questionsSnapshot.docs.map((doc) {
              return {
                "question": doc['question'],
                "answers": List<String>.from(doc['answers']),
                "correctAnswer": doc['correctAnswer'],
              };
            }).toList();
            _seconds = timerDuration; // Set timer duration from Firestore
            isLoading = false;
          });
          startTimer();
        } else {
          setState(() {
            errorMessage = "No questions found!";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Quiz not found!";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching quiz data: $e";
        isLoading = false;
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel(); // Stop timer when it reaches 0
          goToNextQuestion(); // Move to the next question
        }
      });
    });
  }

  void goToHomePage() {
    if (!mounted) return;
    _timer?.cancel();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void checkAnswer(String selectedAnswer) {
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswerCorrect = selectedAnswer == questions[currentQuestionIndex]["correctAnswer"];
    });

    if (isAnswerCorrect) {
      print("Correct answer!");
      Future.delayed(Duration(seconds: 1), () {
        goToNextQuestion();
      });
    } else {
      print("Incorrect answer!");
    }
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        _seconds = 30; // Reset timer for the next question
        selectedAnswer = null; // Reset selected answer
        isAnswerCorrect = false; // Reset correctness flag
      });
    } else {
      // Quiz is complete
      _timer?.cancel();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WinnerPodium()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop timer when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEDD4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: goToHomePage, // Call the function when back button is tapped
              child: Image.asset('assets/images/back.png', width: 30, height: 60),
            ),
            SizedBox(width: 120),
            Text(
              " $_seconds s",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 120),
            Image.asset('assets/images/robot.png', width: 30, height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFFFBF5),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: _seconds > 0
                ? () {
              checkAnswer(""); // Replace with actual logic
            }
                : null, // Navigate when pressed
            style: TextButton.styleFrom(
              backgroundColor: _seconds > 0 ? const Color(0xFFBC8AB3) : Colors.grey,
              foregroundColor: Colors.white,
              fixedSize: const Size(310, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text('Answer'),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestionIndex]["question"],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),

            // First Row of Answer Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < questions[currentQuestionIndex]["answers"].length; i++)
                  answerButton(
                    questions[currentQuestionIndex]["answers"][i],
                    _getButtonColor(i),
                    _getBorderColor(i),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get button color based on index
  Color _getButtonColor(int index) {
    List<Color> colors = [
      Color(0xFF83C1B8),
      Color(0xFFFFA198),
      Color(0xFFFCD192),
    ];
    return colors[index % colors.length];
  }

  // Helper function to get border color based on index
  Color _getBorderColor(int index) {
    List<Color> colors = [
      Color(0xFF0E5C70),
      Color(0xFFD54032),
      Color(0xFFFBBE64),
    ];
    return colors[index % colors.length];
  }

  // Reusable Answer Button
  Widget answerButton(String text, Color color, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextButton(
        onPressed: () => checkAnswer(text),
        style: TextButton.styleFrom(
          backgroundColor: selectedAnswer == text
              ? (isAnswerCorrect ? Colors.green : Colors.red) // Green if correct, red if incorrect
              : color,
          foregroundColor: Colors.black,
          fixedSize: const Size(150, 150),
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}