import 'package:flutter/material.dart';
import 'dart:math';

import 'CompQuiz1.dart';

class CompetitionLoadingAnimation extends StatefulWidget {
  @override
  _CompetitionLoadingAnimationState createState() =>
      _CompetitionLoadingAnimationState();
}

class _CompetitionLoadingAnimationState extends State<CompetitionLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    // Navigate to AnotherPage after 20 seconds
    Future.delayed(Duration(seconds: 20), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Compquiz1()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Custom animated signal lines
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: SignalPainter(_controller.value),
                child: SizedBox(
                  width: 250,
                  height: 250,
                ),
              );
            },
          ),
          // Rotating Satellite
          Transform.rotate(
            angle: pi / 12, // Rotate 15 degrees counterclockwise
            child: Image.asset(
              'assets/images/satellite.gif',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}

class SignalPainter extends CustomPainter {
  final double animationValue;
  SignalPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final satelliteCenterX = size.width / 2 - 20;
    final satelliteCenterY = size.height / 2 - 40; // Raise above satellite

    // Define animated signal lines
    double lineLength = 20;
    final double baseOffset = 20;
    final double angle = pi / 12; // 15-degree angle

    List<Offset> signalPoints = [
      Offset(satelliteCenterX + baseOffset, satelliteCenterY - baseOffset),
      Offset(satelliteCenterX + baseOffset * 2 - 22, satelliteCenterY - baseOffset * 1.5 - 3),
      Offset(satelliteCenterX + baseOffset * 3 - 45, satelliteCenterY - baseOffset * 1.5 - 15),
    ];

    for (int i = 0; i < signalPoints.length; i++) {
      if (animationValue > i * 0.3) {
        final start = signalPoints[i];
        canvas.drawLine(
          start,
          start.translate((lineLength += 15) * cos(angle), lineLength * sin(angle)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant SignalPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// Dummy page to navigate to after 20s
class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Page")),
      body: Center(child: Text("You have been navigated!")),
    );
  }
}
