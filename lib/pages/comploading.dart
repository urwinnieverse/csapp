import 'package:flutter/material.dart';
import 'dart:math';

class CompetitionLoadingAnimation extends StatefulWidget {
  @override
  _CompetitionLoadingAnimationState createState() => _CompetitionLoadingAnimationState();
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
     body:
     Stack(

      children: [

        // // Background GIF
        // Positioned.fill(
        //   child: Image.asset(
        //     'assets/images/stars.gif',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // Custom painter for animated signal lines
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: SignalPainter(_controller.value),
              child: Container(),
            );
          },
        ),
        // Satellite GIF overlay with rotation
        Center(
          child: Transform.rotate(
            angle: pi / 12, // Rotate 15 degrees counterclockwise
            child: Image.asset(
              'assets/images/satellite.gif',
              width: 300,
              height: 300,
            ),
          ),
        ),
      ],
    )
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
      ..strokeWidth = 8;

    final satelliteCenterX = size.width / 2 -10;
    final satelliteCenterY = size.height / 2 - 80; // Raise the lines above the satellite

    // Define line properties for the shape
     double lineLength = 20;
    final double baseOffset = 20;
    final double angle = pi / 12; // 15-degree angle

    // Coordinates for the sequential shape
    List<Offset> signalPoints = [
      Offset(satelliteCenterX + baseOffset, satelliteCenterY - baseOffset),
      Offset(satelliteCenterX + baseOffset * 2 -20, satelliteCenterY - baseOffset * 1.5 - 10),
      Offset(satelliteCenterX + baseOffset * 3 -40, satelliteCenterY - baseOffset * 1.5 -30),
    ];

    // Sequential animation for each stage
    for (int i = 0; i < signalPoints.length; i++) {
      if (animationValue > i * 0.3) {
        final start = signalPoints[i];

        // Draw angled lines
        canvas.drawLine(
          start,
          start.translate((lineLength+=15) * cos(angle), lineLength * sin(angle)),
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
