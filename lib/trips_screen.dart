import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trips',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 51, 97),
      ),
      body: const Center(
        child: Text(
          'Your trips planned on www.spotter.com will appear here',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
