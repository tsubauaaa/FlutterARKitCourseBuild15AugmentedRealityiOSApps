import 'package:ar_mesurement_app/ar_measurement_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ARKit Flutter App',
      home: ArMeasurementScreen(),
    );
  }
}
