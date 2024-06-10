import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import statement
import 'package:logger/logger.dart';
import 'package:testing/cardetails/add_vehicle.dart';
import 'package:testing/main.dart';
import 'package:testing/firebase_service.dart'; // Import the FirebaseService class

final Logger _logger = Logger();

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
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
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool emailExists =
                    await FirebaseService.isEmailExists(emailController.text);
                if (emailExists) {
                  // Email exists, proceed with sign-in
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddVehicleScreen(),
                      ),
                    );
                  } catch (e) {
                    _logger.e('Sign-in error: $e');
                    // You can show an error message to the user here
                  }
                } else {
                  // Email does not exist, handle accordingly
                  // For example, show an error message
                  _logger.e('Email does not exist');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CBB17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },
                  child: const Text("Create an account"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
