import 'package:flutter/material.dart';
import 'package:testing/location_map_screen.dart';
import '../location_service.dart';

class SaveDetailsScreen extends StatelessWidget {
  final String carMake;
  final String carModel;

  SaveDetailsScreen({
    super.key,
    required this.carMake,
    required this.carModel,
  });

  final LocationService _locationService = LocationService();
  String getImagePath() {
    "assets/images/car_images/VolvoS90.jpg";

    return "$carMake$carModel.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              getImagePath(),
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              "$carMake $carModel",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final locationData =
                    await _locationService.getCurrentLocation();
                if (locationData != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationMapScreen(),
                      ));
                } else {}
              },
              child: const Text("ADD VEHICLE"),
            ),
          ],
        ),
      ),
    );
  }
}
