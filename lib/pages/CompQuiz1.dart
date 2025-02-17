import 'package:projects/pages/GenQuiz1.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'compresult.dart';

class Compquiz1 extends StatefulWidget {
  const Compquiz1({super.key});
  @override
  _Compquiz1 createState() => _Compquiz1();
}

class _Compquiz1 extends State<Compquiz1> {
  final TextEditingController textEditingController = TextEditingController();
  int _seconds = 30;
  Timer? _timer;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel(); // Stop timer when it reaches 0
          goToNextPage(); // Automatically navigate when timer reaches zero
        }
      });
    });
  }

  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const quizScreen()), // Navigate to NextScreen
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop timer when screen is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(

            backgroundColor: Color(0xFFFFEDD4),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Image.asset('assets/images/back.png', width: 30, height: 60),
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
                    MaterialPageRoute(builder: (context) => quizScreen()),
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



            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    'Write a code segment that \n that produces the output below:'
                        '\n\nHello World !\nHello World !\nHello World !\nHello World !',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: 350, // Fixed width
                      height: 250, // Fixed height
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFBF5), // Light background color
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, // Soft shadow
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 2), // Slight downward shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft, // Align text to start
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          controller: textEditingController,
                          maxLines: null, // Allow multiple lines
                          expands: true, // Makes TextField fill the container
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none, // No default border
                            hintText: "Enter your answer here...",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),

                      ),
                    ),
                  ),


                ],
              ),
            ),
            ),
        );
  }
}
