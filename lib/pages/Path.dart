import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'lesson_screen.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pathscreen extends StatelessWidget {
  final String courseName;
  final double completionPercentage;

  Pathscreen({required this.courseName, required this.completionPercentage});

  // Fetch lessons from Firebase Firestore
  Future<List<Map<String, String>>> fetchLessons() async {
    List<Map<String, String>> lessons = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseName)
          .collection('lessons')
          .orderBy('order') // Ensure lessons are ordered
          .get();

      for (var doc in querySnapshot.docs) {
        lessons.add({
          "title": doc['title'],
          "description": doc['description'],
        });
      }
    } catch (e) {
      print("Error fetching lessons: $e");
    }
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Courses"), backgroundColor: Colors.orange[50]),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchLessons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading lessons"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No lessons available"));
          }

          List<Map<String, String>> lessons = snapshot.data!;

          return SingleChildScrollView(
            child: SizedBox(
              height: lessons.length * 170.0 + 350, // Ensure space for all elements
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset('assets/images/stars.gif', fit: BoxFit.cover),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PathPainter(lessons.length),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Welcome to $courseName",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: lessons.asMap().entries.map((entry) {
                          int index = entry.key;
                          return Positioned(
                            top: 220.0 + (index * 150.0),
                            left: (index.isEven) ? 100 : 200,
                            child: FlipCardWidget(
                              lessonTitle: entry.value["title"]!,
                              description: entry.value["description"]!,
                              courseName: courseName, // Pass courseName for proper lesson selection
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}





class PathPainter extends CustomPainter {
  final int lessonCount;

  PathPainter(this.lessonCount);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Path path = Path();

    double startX = 175; // Starting X position (matches first card)
    double startY = 270; // Starting Y position (just above the first card)

    for (int i = 0; i < lessonCount - 1; i++) {
      double nextX = (i % 2 == 0) ? 275 : 175; // Alternate between left and right
      double nextY = startY + 150; // Move downwards to next card

      path.moveTo(startX, startY);
      path.quadraticBezierTo(
        startX, nextY - 75, // Control point (midway)
        nextX, nextY, // Next card position
      );

      startX = nextX;
      startY = nextY;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class FlipCardWidget extends StatefulWidget {
  final String lessonTitle;
  final String description;
  final String courseName; // Pass the course name to filter lesson content

  FlipCardWidget({required this.lessonTitle, required this.description, required this.courseName});

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  final GlobalKey<FlipCardState> _flipKey = GlobalKey<FlipCardState>();
  bool isFlipped = false;

  void _handleTap(BuildContext context) {
    if (!isFlipped) {
      _flipKey.currentState?.toggleCard();
      setState(() {
        isFlipped = true;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LessonScreen(
            courseName: widget.courseName, // Pass course name to differentiate lessons
            lessonTitle: widget.lessonTitle,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: FlipCard(
        key: _flipKey,
        flipOnTouch: false,
        direction: FlipDirection.HORIZONTAL,
        front: _buildFrontCard(),
        back: _buildBackCard(),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Text(
          widget.lessonTitle,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          widget.description,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
