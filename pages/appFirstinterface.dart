import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login.dart';
import 'signin.dart';

class appFirstinterface extends StatelessWidget {
  const appFirstinterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 237, 212),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            bottom: 400,
            child: Image.asset('assets/images/alien.png', width: 590),
          ),
          Positioned(
            top: 159,
            right: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Are you',
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Orbiter',
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.greenAccent,
                            offset: Offset(3.0, 3.0),
                          ),
                        ],
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 2,
                  pause: const Duration(milliseconds: 500),
                ),
                const SizedBox(height: 5),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'an Alien?',
                      textStyle: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Orbiter',
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.greenAccent,
                            offset: Offset(3.0, 3.0),
                          ),
                        ],
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 2,
                  pause: const Duration(milliseconds: 500),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.2),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      LoginScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Starting position (right)
                    const end = Offset.zero; // Final position (center)
                    const curve = Curves.easeInOut; // Smooth curve transition

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 254, 249, 242),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 140),
                child: const Text(
                  'Yes I Am ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "we are alien!! ",
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment(0.0, 0.6),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SigninScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(2.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 254, 249, 242),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 130),
                child: const Text(
                  'No, I Am Not ',
                  style: TextStyle(
                    fontFamily: 'alien',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
