import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_service.dart';
import '../providers/theme_provider.dart';
import 'detail_screen.dart';
import 'home_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();
  final List<String> cities = ["Dakar", "Paris", "New York", "Tokyo", "Berlin"];
  List<Map<String, dynamic>> weatherData = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      List<Map<String, dynamic>> results = [];
      for (var city in cities) {
        final data = await _service.fetchWeather(city);
        if (data != null) {
          results.add(data);
        }
      }
      setState(() {
        weatherData = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Impossible de récupérer les données météo 😢";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Données météo"),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDark = themeProvider.themeMode == ThemeMode.dark;
              return IconButton(
                icon: Icon(
                  isDark ? Icons.nightlight_round : Icons.wb_sunny,
                  color: isDark ? Colors.yellow : Colors.orange,
                ),
                onPressed: () {
                  themeProvider.toggleTheme(!isDark);
                },
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!,
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadWeather,
                        child: const Text("Réessayer"),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: weatherData.length,
                        itemBuilder: (context, index) {
                          final city = weatherData[index];
                          return ListTile(
                            title: Text(city["name"]),
                            subtitle: Text(
                                "${city["main"]["temp"]}°C - ${city["weather"][0]["description"]}"),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailScreen(city: city),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Recommencer"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
    );
  }
}
