import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testing/details/personal_details.dart';
import 'package:testing/firebase_service.dart';
import 'package:testing/main.dart';

final Logger _logger = Logger();

FirebaseService firebaseService = FirebaseService();

class SignUpWithEmailScreen extends StatelessWidget {
  const SignUpWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up with Email",
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
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool? emailExists =
                    await FirebaseService.isEmailExists(emailController.text);
                emailExists ??= false;
                if (emailExists) {
                  _logger.e('Email already in use');
                } else {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    context.read<UserDataProvider>().init(
                          emailController.text,
                          passwordController.text,
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalDetailsScreen(),
                      ),
                    );
                  } catch (e) {
                    _logger.e('Sign-up error: $e');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CBB17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Sign up",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
