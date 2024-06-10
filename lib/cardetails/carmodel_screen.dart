import 'package:flutter/material.dart';
import 'package:testing/cardetails/saveDetails_screen.dart';
// ignore: unused_import
import '../location_map_screen.dart';

class CarModelScreen extends StatelessWidget {
  final String make;
  final String userId; // Added userId parameter here
  const CarModelScreen(
      {super.key,
      required this.make,
      required this.userId}); // Added 'required' for userId

  @override
  Widget build(BuildContext context) {
    List<String> carModels = [];

    if (make == "Toyota") {
      carModels = ["Camry", "Urban Cruiser Hyryder", "Innova Hycross"];
    } else if (make == "Honda") {
      carModels = ["e:HEV", "Elevate", "Elegent Edition"];
    } else if (make == "Tata") {
      carModels = [
        "Tigor",
        "Nexon",
        "Tiago",
        "Altroz",
        "Punch",
        "Sierra",
        "Blackbird"
      ];
    } else if (make == "Audi") {
      carModels = [
        "e-tron",
        "e-tron GT",
        "RS e-tron GT",
        "Q8 Sportback e-tron",
        "Q8 e-tron"
      ];
    } else if (make == "Volvo") {
      carModels = ["C40 Recharge", "XC40 Recharge", "XC60", "XC90", "S90"];
    } else if (make == "Hyundai") {
      carModels = ["Kona Electric", "IONIQ 5"];
    } else if (make == "MG") {
      carModels = ["Commet EV", "ZS EV"];
    } else if (make == "Mahindra") {
      carModels = [
        "eVerito",
        "eSupro",
        "Treo e-Rickshaw",
        "E20 Plus",
        "eAlfa Mini e-Rickshaw"
      ];
    } else if (make == "Kia") {
      carModels = ["EV6"];
    } else if (make == "BMW") {
      carModels = ["i7", "iX", "i4", "iX1"];
    } else if (make == "Mercedes-Benz") {
      carModels = ["EQE SUV", "EQB", "EQS", "AMG EQS", "EQC"];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Car Model for $make"),
      ),
      body: ListView.builder(
        itemCount: carModels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(carModels[index]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaveDetailsScreen(
                      carMake: make,
                      carModel: carModels[index],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
