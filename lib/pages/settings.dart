import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = false;
  bool musicSounds = true;
  bool vibrations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCEED9), // Beige background
      body:

      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/close2.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 40),
            buildToggleRow("Notifications", notifications, (value) {
              setState(() {
                notifications = value;
              });
            }),
            buildToggleRow("Music/Sounds", musicSounds, (value) {
              setState(() {
                musicSounds = value;
              });
            }),
            buildToggleRow("Vibrations", vibrations, (value) {
              setState(() {
                vibrations = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildToggleRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
      Transform.scale(
      scale: 1.2, // Adjust this value to make the toggle bigger or smaller
      child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Color(0xFF9E6B94), // Purple color
            inactiveThumbColor: Color(0xFF9E6B94),
            inactiveTrackColor: Colors.white,
          ),
      )
        ],
      ),
    );
  }
}
