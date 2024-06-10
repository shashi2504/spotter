import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testing/firebase_service.dart';
import '../cardetails/add_vehicle.dart';

final Logger _logger = Logger();

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Personal Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(143, 0, 0, 0),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(143, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseService.savePersonalDetails(
                    nameController.text,
                    phoneNumberController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddVehicleScreen(),
                    ),
                  );
                } catch (e) {
                  // Handle errors
                  _logger.e('Error: $e');
                  // You can show an error message to the user here
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CBB17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Save Details",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
