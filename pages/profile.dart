import 'package:flutter/material.dart';
import 'settings.dart';
import 'bottom_navigation.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int xp = 130924;
  int streak = 284;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEDD4),
      body: Column(
        children: [
          // Top Section (Green Background with Avatar and Settings Icon)
          Container(
            height: 300,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFFCFF5D4), // Light green background
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute(SettingsScreen()));
                    },
                    child: Image.asset('assets/images/settings3.png', width: 25),
                  ),
                ),
            Align(
              alignment: Alignment.bottomCenter,
                child:
                Image.asset('assets/images/alien1.png', width: 200, height: 200),
            )
              ],
            ),
          ),

          SizedBox(height: 35),

          // User Info Section (Outside the Green Box)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Text('Code Space', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('13.09.2024', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('      @Code_Space  ', style: TextStyle(color: Colors.black54)),
                  Text('            5 friends                         ', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),

          SizedBox(height: 40),

          // Stats Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('   $xp', '   Total XP', 'assets/images/crystals2.png'),
                _buildStatCard('$streak', '     Day Streak', 'assets/images/petrol-can1.png'),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Courses & Achievements
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionCard('Courses', 'Python', 'assets/images/python.png'),
                _buildSectionCard('Achievements', 'No Achievements', null),
              ],
            ),
          ),

          Spacer(),


        ],
      ),
        bottomNavigationBar: BottomNavigation()
    );
  }

  // Stats Card Widget
  Widget _buildStatCard(String value, String label, String imagePath) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          imagePath != null ? Image.asset(imagePath, width: 35) : SizedBox.shrink(),
          SizedBox(height: 25),
          Column(
            children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey,fontSize: 13)),])
        ],
      ),
    );
  }

  // Courses & Achievements Card Widget
  Widget _buildSectionCard(String title, String content, String? imagePath) {
    return Container(
      width: 160,
      height: 160,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('View all', style: TextStyle(color: Colors.blue, fontSize: 14)),
            ],
          ),
          Spacer(),
          imagePath != null ? Image.asset(imagePath, width: 85) : SizedBox.shrink(),
          SizedBox(height: 30),
        ],
      ),
    );
}
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
