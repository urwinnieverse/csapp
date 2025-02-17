import 'dart:async';
import 'package:flutter/material.dart';
import 'compresult.dart';

class quizScreen extends StatefulWidget {
  const quizScreen({super.key});

  @override
  _quizScreenState createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {
  final TextEditingController textEditingController = TextEditingController();
  int _seconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
      });
    });
  }
  void goToHomePage() {
    if (!mounted) return;
    _timer?.cancel();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void checkAnswer(String selectedAnswer) {
    print("User selected: $selectedAnswer"); // Replace with actual logic
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
            onPressed: _seconds > 0 ? (){Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WinnerPodium()),
            );}:null, // Navigate when pressed
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                answerButton("Hi", Color(0xFF83C1B8),Color(0xFF0E5C70)),
                const SizedBox(width: 20),
                answerButton("Hello", Color(0xFFFFA198),Color(0xFFD54032)),
              ],
            ),

            const SizedBox(height: 20),

            // Second Row of Answer Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                answerButton('"Hello"', Color(0xFFFCD192),Color(0xFFFBBE64)),
                const SizedBox(width: 20),
                answerButton('"Hi"', Color(0xFF68A6B6),Color(0xFF3B7169 )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Answer Button
  Widget answerButton(String text, Color color,Color borderColor) {
    return TextButton(
        onPressed: () => checkAnswer(text),
        style: TextButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          fixedSize: const Size(150, 150),
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        ),
        child: Text(text,style: const TextStyle(fontSize: 28),),
        );
  }
}
