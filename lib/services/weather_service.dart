import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey = "27727a3450e7b7561db3768d0dad651d"; // << Mets ta clé OpenWeather ici

  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=fr";

    try {
      final response = await _dio.get(url);
      return response.data;
    } catch (e) {
      print("Erreur API : $e");
      return null;
    }
  }
}
