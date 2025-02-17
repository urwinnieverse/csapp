import 'package:flutter/material.dart';
import 'dart:math';

class SpaceLoadingScreen extends StatefulWidget {
  @override
  _SpaceLoadingScreenState createState() => _SpaceLoadingScreenState();
}

class _SpaceLoadingScreenState extends State<SpaceLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Time for one full orbit
    )..repeat(); // Loop indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/stars.gif"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Positioned(
              child: Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double angle = _controller.value * 2 * pi; // Convert animation value to radians
                double radius = 150; // UFO orbit radius
                return Positioned(
                  left: MediaQuery.of(context).size.width / 2 + radius * cos(angle) - 25,
                  top: MediaQuery.of(context).size.height / 2 + radius * sin(angle) - 25,
                  child: child!,
                );
              },
              child: Image.asset('assets/images/ufo.png',width: 100, height: 100,),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SpaceLoadingScreen(),
  ));
}
