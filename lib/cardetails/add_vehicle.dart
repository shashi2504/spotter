import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testing/cardetails/carmake_screen.dart';

final Logger _logger = Logger();

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image-4.jpg',
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              "Personalize Your Experience by Adding a Vehicle",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarMakeScreen(),
                    ));
                _logger.d("Add Vehicle button pressed");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "ADD VEHICLE",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _logger.d("Add Later button pressed");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "ADD LATER",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _logger.d("Can't Find Your Vehicle button pressed");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "CAN'T FIND YOUR VEHICLE?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
