import 'package:flutter/material.dart';
import 'package:testing/booking_form_screen.dart';

class ChargingStationDetailsScreen extends StatelessWidget {
  final String stationName;
  final String address;
  final String chargerType;

  const ChargingStationDetailsScreen({
    super.key,
    required this.stationName,
    required this.address,
    required this.chargerType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Station Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $stationName',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Address: $address',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Plug Type: $chargerType',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        const Text('Charger'),
                        Container(
                          height: 2,
                          width: 50,
                          color: const Color.fromARGB(255, 113, 39, 161),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Location Details'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Location: $address'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Details'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('Reviews'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                      Colors.grey.shade200
                    ],
                  ),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VEEV004-DC1',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'DC |',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '33kW',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      '₹ 22/kWh',
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Connector 1:',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          ' Available',
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingFormScreen(stationName: stationName),
                    ),
                  );
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
