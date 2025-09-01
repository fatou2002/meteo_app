import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MeteoApp());
}

class MeteoApp extends StatelessWidget {
  const MeteoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Météo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(), 
    );
  }
}
