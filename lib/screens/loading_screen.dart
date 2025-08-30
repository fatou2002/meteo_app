import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'weather_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;
  bool showRestart = false;
  late Timer timer;

  final List<String> messages = [
    "Nous téléchargeons les données…",
    "C’est presque fini…",
    "Plus que quelques secondes avant d’avoir le résultat…",
  ];
  int currentMessage = 0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    progress = 0;
    showRestart = false;

    timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
      setState(() {
        progress += 0.05;

        if (progress >= 1) {
          t.cancel();
          showRestart = true;
        }

        currentMessage = (currentMessage + 1) % messages.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chargement des données")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showRestart
                ? ElevatedButton(
                    onPressed: () {
                      _startLoading();
                      // Après redémarrage, naviguer vers tableau météo
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WeatherScreen()),
                        );
                      });
                    },
                    child: const Text("Recommencer 🔄"), // ✅ corrigé
                  )
                : CircularPercentIndicator(
                    radius: 80,
                    lineWidth: 15,
                    percent: progress,
                    animation: true,
                    progressColor: Colors.blue,
                    backgroundColor: Colors.grey.shade300,
                    center: Text("${(progress * 100).toInt()}%"),
                  ),
            const SizedBox(height: 20),
            if (!showRestart)
              Text(
                messages[currentMessage],
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
