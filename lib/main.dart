import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testing/details/signin_screen.dart';
import 'details/signup_email.dart';

class UserDataProvider extends ChangeNotifier {
  late String _email;
  late String _password;

  String get email => _email;
  String get password => _password;

  void setEmailAndPassword(String email, String password) {
    _email = email;
    _password = password;
    notifyListeners();
  }

  void init(String text, String text2) {}
}

final Logger _logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionScreenPage(),
    );
  }
}

class IntroductionScreenPage extends StatelessWidget {
  IntroductionScreenPage({super.key});
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Charging Slot Locator",
          body: "Find and reserve charging slots for your electric vehicle.",
          image: Image.asset(
            'assets/images/image-1.png',
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Locate Charging Slots",
          body:
              "Easily locate and navigate to available charging slots near you.",
          image: Image.asset(
            'assets/images/image-2.png',
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Reserve Your Slot",
          body:
              "Reserve a charging slot in advance to ensure availability when you arrive.",
          image: Image.asset(
            'assets/images/image-3.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      },
      onSkip: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      globalBackgroundColor: Colors.white,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
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
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _logger.d("Sign up with Google");
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 10),
            SignInButton(
              Buttons.Apple,
              onPressed: () {
                _logger.d("Sign up with Apple");
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpWithEmailScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular((8.0)))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.black),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Sign up with Email",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already a member? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text("Sign In"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
