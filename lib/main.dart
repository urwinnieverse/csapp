import 'package:flutter/material.dart';
import 'pages/profile.dart';
import 'pages/login.dart';
import 'pages/signin.dart';
import 'pages/settings.dart';
import 'pages/loading.dart';
import 'pages/comploading.dart';
import 'pages/compresult.dart';
import 'pages/GenQuiz1.dart';
import 'pages/CompQuiz1.dart';
import 'pages/Competition.dart';
import 'pages/Path.dart';
import 'pages/courses_screen.dart';
import 'pages/appFirstinterface.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: appFirstinterface()
    );
  }
}


