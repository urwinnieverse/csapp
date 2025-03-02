import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // For YouTube video integration
// import 'quiz2.dart'; // Import your quiz page
// import 'draggableQuiz.dart'; // Import your draggable quiz page

class LessonScreen extends StatefulWidget {
  final String lessonId; // Use lessonId to fetch specific lesson data
  final String courseId; // Use courseId to fetch specific course data

  LessonScreen({required this.lessonId, required this.courseId});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int currentPage = 0;
  String lessonName = "";
  String lessonVideoUrl = "";
  // List<Map<String, dynamic>> lessonQuestions = []; // List of questions for the lesson (commented out)
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchLessonData();
  }

  // Fetch lesson data from Firebase Firestore
  Future<void> fetchLessonData() async {
    try {
      // Fetch the lesson document
      DocumentSnapshot lessonSnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .collection('lessons')
          .doc(widget.lessonId)
          .get();

      if (lessonSnapshot.exists) {
        setState(() {
          lessonName = lessonSnapshot['title']; // Fetch lesson name
          lessonVideoUrl = lessonSnapshot['videoUrl']; // Fetch video URL
          // lessonQuestions = List<Map<String, dynamic>>.from(lessonSnapshot['questions']); // Fetch questions (commented out)
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Lesson not found!";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching lesson data: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text(lessonName),
        backgroundColor: Colors.orange[50],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: _buildLessonContent(currentPage),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentPage > 0)
                TextButton(
                  onPressed: () => setState(() => currentPage--),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFBC8AB3),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(310, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Back'),
                ),
              // if (currentPage < lessonQuestions.length) // Commented out
              //   TextButton(
              //     onPressed: () => setState(() => currentPage++),
              //     style: TextButton.styleFrom(
              //       backgroundColor: Color(0xFFBC8AB3),
              //       foregroundColor: Colors.white,
              //       fixedSize: const Size(310, 50),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //     ),
              //     child: const Text('Next'),
              //   ),
            ],
          ),
        ],
      ),
    );
  }

  // Build lesson content dynamically
  Widget _buildLessonContent(int pageIndex) {
    if (pageIndex == 0) {
      // First page: Lesson name and video
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            lessonName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          if (lessonVideoUrl.isNotEmpty)
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(lessonVideoUrl)!,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
        ],
      );
    } else {
      // Subsequent pages: Questions (commented out)
      // final question = lessonQuestions[pageIndex - 1]; // Get the current question (commented out)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the question text (commented out)
          // Text(
          //   question['question'],
          //   style: TextStyle(fontSize: 18),
          //   textAlign: TextAlign.center,
          // ),
          SizedBox(height: 20),

          // Handle draggable questions (commented out)
          // if (question['type'] == 'draggable')
          //   DraggableQuiz(
          //     question: question,
          //     onAnswerSelected: (answer) {
          //       // Handle answer selection for draggable questions
          //     },
          //   ),

          // Handle multiple-choice questions (commented out)
          // if (question['type'] == 'multipleChoice')
          //   ...question['options'].map((option) {
          //     return ElevatedButton(
          //       onPressed: () {
          //         // Handle answer selection for multiple-choice questions
          //       },
          //       child: Text(option),
          //     );
          //   }).toList(),
        ],
      );
    }
  }
}