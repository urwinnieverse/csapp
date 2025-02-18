import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'courses_screen.dart';
import 'appFirstInterface.dart'; // Import the previous page
import 'signin.dart'; // Import the SigninScreen page

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAlien = false;
//text controller to keep track of whats inside the text field ounce user types//
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
//login method
  Future _login() async { // so ounce the user presses the button [on pressed] they will sign in using email and pass

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        print("Login successful!");  // Debugging print

        // Navigate to CoursesScreen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CoursesScreen()),
        );
      } catch (e) {
        print("Login failed: $e");  // Print error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.toString()}")),
        );
      }
    }
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();  //for memory managment//
    _passwordController.dispose(); //for memory managment//
    _controller.dispose();
    super.dispose();
  }

  // Custom method to navigate with smooth transition
  void _navigateWithTransition(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide in from right
          const end = Offset.zero; // Final position in the center
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/alienbackground.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(75.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      "assets/images/alien.png",
                      width: 290,
                    ),
                  ),
                  SizedBox(height: 0.1),
                  Text("Welcome Back!",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 50),
                  Text("Enter your Alien e-mail",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(
                    height: 40,
                    child: TextField(//for email and give it the controller//
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10, height: 20),
                  Text("Enter your Password",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(
                    height: 40,
                    child: TextField(//for password and give it the controller//
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    ),
                    onPressed: _login, //navigation to course screen moved to auth_page//
                    child: Text("I am Back!",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: _isAlien
                        ? () => _navigateWithTransition(appFirstinterface()) // Navigate to home screen
                        : () => _navigateWithTransition(SigninScreen()), // Navigate to SigninScreen
                    child: Text(
                      _isAlien
                          ? "You Are An Alien! Return Home"
                          : "Not an Alien Yet? Sign In to Become One!",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
