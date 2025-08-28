import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;
  final List<String> messages = [
    "Nous téléchargeons les données…",
    "C'est presque fini…",
    "Plus que quelques secondes avant d’avoir le résultat…"
  ];
  int messageIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        progress += 0.2;
        messageIndex = (messageIndex + 1) % messages.length;
      });
      if (progress >= 1) {
        t.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WeatherScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearPercentIndicator(
              width: 200,
              lineHeight: 14,
              percent: progress,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(messages[messageIndex]),
          ],
        ),
      ),
    );
  }
}
