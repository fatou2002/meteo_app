import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> city;

  const DetailScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final coords = LatLng(
      city["coord"]["lat"].toDouble(),
      city["coord"]["lon"].toDouble(),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Détails : ${city["name"]}")),
      body: Column(
        children: [
          Text(
            "Météo actuelle à ${city["name"]}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("🌡 Température : ${city["main"]["temp"]}°C"),
          Text("💧 Humidité : ${city["main"]["humidity"]}%"),
          Text("🌬 Vent : ${city["wind"]["speed"]} m/s"),
          Text("📊 Pression : ${city["main"]["pressure"]} hPa"),
          Text("☁️ Ciel : ${city["weather"][0]["description"]}"),
          const SizedBox(height: 20),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: coords,
                initialZoom: 10,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.meteo_app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: coords,
                      width: 60,
                      height: 60,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
