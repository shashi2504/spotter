import 'package:flutter/material.dart';

class ChargingStationDetailsScreen extends StatelessWidget {
  final String stationName;
  final String address;
  final String chargerType;

  const ChargingStationDetailsScreen({
    super.key,
    required this.stationName,
    required this.address,
    required this.chargerType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Station Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $stationName',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Address: $address',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Charger Type: $chargerType',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
