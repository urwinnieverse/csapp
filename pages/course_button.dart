import 'package:flutter/material.dart';


class CourseButton extends StatefulWidget {

  final String? imagePath;
  final String text;
  final Color borderColor;
  final int completionPercentage;
  final VoidCallback onGoToCourse;

  CourseButton({
    this.imagePath,
    required this.text,
    required this.borderColor,
    required this.completionPercentage,
    required this.onGoToCourse,
} );

  @override
  _CourseButtonState createState() => _CourseButtonState();
}// class CourseButton


// كلاس الحالات
class _CourseButtonState extends State<CourseButton> {
  //الحالة الطبيعية
bool _isExpanded = false ;

//اذا المستخدم ضغط على الكورس راح يصيرله توسيع من هذي الدالة
  void _toggleExpansion() {
    print("Toggled expansion");
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }


  @override
  Widget build(BuildContext context) {
    double progressBarWidth = MediaQuery.of(context).size.width * 0.7;
    return GestureDetector(
      onTap: _toggleExpansion,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: _isExpanded ? 25 : 15, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: widget.borderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.imagePath != null
                    ? Image.asset(widget.imagePath!, width: 55, height: 55)
                    : Icon(Icons.visibility, size: 30, color: widget.borderColor),
                SizedBox(width: 10),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                if (_isExpanded)
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: widget.borderColor),
                    onPressed: widget.onGoToCourse,
                  ),
              ],
            ),
            if (_isExpanded) ...[
              SizedBox(height: 10),
              SizedBox(
                width: progressBarWidth,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: (widget.completionPercentage / 100) * progressBarWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        color: widget.borderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${widget.completionPercentage}%",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}