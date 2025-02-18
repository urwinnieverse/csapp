import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'courses_screen.dart';


class SigninScreen extends StatelessWidget {
  //text controller to keep track of whats inside the text field ounce user types//
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  
  // Custom method to navigate with smooth transition
  void _navigateWithTransition(BuildContext context, Widget screen) {
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
//signin method
  Future<void> _signin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // ✅ Navigate to CoursesScreen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoursesScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use.";
      } else if (e.code == 'weak-password') {
        errorMessage = "The password is too weak.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
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
              child:SingleChildScrollView(  //gets rid of the bufferverflow//
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/alien.png", width: 290),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text("YOU ARE NOW A",
                            style: TextStyle(
                                height: 1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text("PROGRAMMING ALIEN!",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Enter your Alien Name", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10, height: 10),
                  Text("Enter your Alien Age", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  SizedBox(
                    height: 40, width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  //email textfield//
                  SizedBox(height: 10),
                  Text("Enter your Alien E-mail", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "e.g. Alien02@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  //password textfield//
                  SizedBox(height: 10),
                  Text("Choose a weird Password", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  SizedBox(
                    height: 40,
                    child: TextField(
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
                    onPressed: () => _signin(context),
                    child: Text("BECOME AN ALIEN", style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                  ),
             //     SizedBox(height: 60),
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
