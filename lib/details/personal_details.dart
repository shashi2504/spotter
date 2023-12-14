import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testing/details/signup_email.dart';
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
        title: const Text("Personal Details"),
      ),
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
              onPressed: () {
                _logger.d("Save personal details");

                final userEmail = context.read<UserDataProvider>().email;
                final userPassword = context.read<UserDataProvider>().password;

                _logger.d("User Email: $userEmail");
                _logger.d("User Password: $userPassword");
                _logger.d("User Name: ${nameController.text}");
                _logger.d("User Phone Number: ${phoneNumberController.text}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddVehicleScreen(),
                  ),
                );
              },
              child: const Text("Save Details"),
            ),
          ],
        ),
      ),
    );
  }
}
