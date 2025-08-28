import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import 'detail_screen.dart';

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
        if (data != null) results.add(data);
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
      appBar: AppBar(title: const Text("Tableau météo")),
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
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue[100]),
                    columns: const [
                      DataColumn(label: Text("Ville")),
                      DataColumn(label: Text("Température 🌡")),
                      DataColumn(label: Text("Humidité 💧")),
                      DataColumn(label: Text("Ciel ☁️")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows: weatherData.map((city) {
                      return DataRow(
                        cells: [
                          DataCell(Text(city["name"])),
                          DataCell(Text("${city["main"]["temp"]}°C")),
                          DataCell(Text("${city["main"]["humidity"]}%")),
                          DataCell(Text("${city["weather"][0]["description"]}")),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailScreen(city: city),
                                  ),
                                );
                              },
                              child: const Text("Détails"),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
    );
  }
}
