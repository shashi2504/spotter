import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testing/details/personal_details.dart';

final Logger _logger = Logger();

class SignUpWithEmailScreen extends StatelessWidget {
  const SignUpWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up with Email"),
      ),
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
              onPressed: () {
                _logger.d("Perform email sign-up");

                context.read<UserDataProvider>().setEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonalDetailsScreen(),
                  ),
                );
              },
              child: const Text("Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDataProvider extends ChangeNotifier {
  late String email;
  late String password;

  void setEmailAndPassword(String userEmail, String userPassword) {
    email = userEmail;
    password = userPassword;
    notifyListeners();
  }
}
