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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Grille d'infos météo en petits carrés ---
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
                children: [
                  _buildInfoCard(Icons.thermostat, "Température",
                      "${city["main"]["temp"]}°C", Colors.red),
                  _buildInfoCard(Icons.water_drop, "Humidité",
                      "${city["main"]["humidity"]}%", Colors.blue),
                  _buildInfoCard(Icons.air, "Vent",
                      "${city["wind"]["speed"]} m/s", Colors.green),
                  _buildInfoCard(Icons.speed, "Pression",
                      "${city["main"]["pressure"]} hPa", Colors.orange),
                  _buildInfoCard(Icons.cloud, "Ciel",
                      city["weather"][0]["description"], Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 10),

            
            SizedBox(
              height: 300, 
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
      ),
    );
  }

  
  Widget _buildInfoCard(
      IconData icon, String title, String value, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 6),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
