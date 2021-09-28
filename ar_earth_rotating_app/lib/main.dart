import 'package:flutter/material.dart';

import 'earth_rotating_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ARKit Flutter App',
      home: EarthRotatingScreen(),
    );
  }
}
