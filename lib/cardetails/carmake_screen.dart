import 'package:flutter/material.dart';
import 'package:testing/cardetails/Carmodel_screen.dart';

class CarMakeScreen extends StatelessWidget {
  const CarMakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Car Make"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Toyota"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(make: "Toyota"),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Honda"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(make: "Honda"),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Tata"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Tata",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Audi"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Audi",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Volvo"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Volvo",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Hyundai"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Hyundai",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("MG"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "MG",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Mahindra"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Mahindra",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Kia"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Kia",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("BMW"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "BMW",
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Mercedes-Benz"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarModelScreen(
                    make: "Mercedes-Benz",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
