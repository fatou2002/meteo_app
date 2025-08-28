class Weather {
  final String city;
  final double temperature;
  final String description;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.humidity,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      city: map['city'] ?? '',
      temperature: (map['temperature'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      windSpeed: (map['windSpeed'] ?? 0).toDouble(),
      humidity: map['humidity'] ?? 0,
    );
  }
}
