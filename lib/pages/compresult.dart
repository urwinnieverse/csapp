import 'package:flutter/material.dart';
import 'Competition.dart';

class WinnerPodium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
     body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'And the winners are:',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPodiumColumn('2nd', Color(0xFF0E5C70), '@someone', 150),
              _buildPodiumColumn('1st', Color(0XFFD54032), '@someone', 180),
              _buildPodiumColumn('3rd', Color(0xFF0E8C38), '@someone', 120),
            ],
          ),
          Text('Congratulations!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87,),
          ),
          // Row with three containers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Container 1: Total XP (Red)
              Container(
                width: 100, // Adjust width to match the image
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0XFFD54032),
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow effect
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total XP", style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 5),
                    // White rounded rectangle background for the number
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Text(
                        "xp", // Display XP here
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0XFFD54032)),
                      ),
                    ),
                  ],
                ),
              ),

              // Container 2: Final Score (Green)
              Container(
                width: 100, // Adjust width to match the image
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color:Color(0xFF0E8C38), // Green background
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow effect
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Final Score", style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 5),
                    // White rounded rectangle background for the score
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Text("score ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0E8C38))),
                    ),
                  ],
                ),
              ),

              // Container 3: Level (Blue)
              Container(
                width: 100, // Adjust width to match the image
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blue, // Blue background
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow effect
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Level", style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 5),
                    // White rounded rectangle background for the number
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 38, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Text("1", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD291BC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            ),


            onPressed: (){Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CompetitionScreen()),
            );},
            child: Text(
              'Finish',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildPodiumColumn(String place, Color color, String username, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.7),
          radius: 32,
          child: Text(
            username,
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        Container(
          alignment: Alignment.center,
          width: 110,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              place,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
