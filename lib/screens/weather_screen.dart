import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_service.dart';
import 'detail_screen.dart';

// Création du ThemeManager (ChangeNotifier)
class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: const _WeatherScreenContent(),
    );
  }
}

class _WeatherScreenContent extends StatefulWidget {
  const _WeatherScreenContent();

  @override
  State<_WeatherScreenContent> createState() => _WeatherScreenContentState();
}

class _WeatherScreenContentState extends State<_WeatherScreenContent> {
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
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeManager.themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tableau météo"),
          actions: [
            IconButton(
              icon: Icon(
                themeManager.themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                themeManager.toggleTheme();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _loadWeather();
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
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor:
                          MaterialStateProperty.all(Colors.blue[100]),
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
                            DataCell(
                                Text("${city["weather"][0]["description"]}")),
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
      ),
    );
  }
}
