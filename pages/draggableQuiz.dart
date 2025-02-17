import 'package:flutter/material.dart';

class DraggableAnswer extends StatelessWidget {
  final String text;
  final Color outerColor;
  final Color innerColor;

  const DraggableAnswer({
    required this.text,
    required this.outerColor,
    required this.innerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: text,
      child: answerButton(text, outerColor, innerColor),
      feedback: Material(
        color: Colors.transparent,
        child: answerButton(text, outerColor, innerColor),
      ),
      childWhenDragging: Container(),
    );
  }

  Widget answerButton(String text, Color outerColor, Color innerColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: innerColor,  // Inner color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: outerColor, width: 2),  // Outer border color
      ),

      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 23,fontWeight: FontWeight.bold),
      ),
    );
  }
}