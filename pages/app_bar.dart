import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,  // Remove the back button
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/images/crystals2.png', width: 30, height: 30),
        Text("50%"),
        Image.asset('assets/images/petrol-can1.png', width: 30, height: 30),
        Text("50%"),
        Image.asset('assets/images/oxygen-tank1.png', width: 30, height: 30),
        Text("40%"),
        Image.asset('assets/images/notification.png', width: 30, height: 30),
      ],
    ),
  );
}
