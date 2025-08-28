import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'screens/home_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/results_screen.dart';
import 'screens/city_detail_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/results': (context) => const ResultsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/cityDetail') {
          final args = settings.arguments as Weather;
          return MaterialPageRoute(
            builder: (_) => CityDetailScreen.fromMap(args),
          );
        }
        return null;
      },
    );
  }
}
