import 'package:flutter/material.dart';
import 'package:testing/booking_confirmation_screen.dart';
import 'package:testing/location_map_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final String stationName;

  const BookingFormScreen({super.key, required this.stationName});

  @override
  // ignore: library_private_types_in_public_api
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String currentCharge = '10%'; // Initial value

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<String> percentages = [
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Charging Station'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Station: ${widget.stationName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Add booking form here
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name can\'t be empty';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'phone number can\'t be empty';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Current Charge'),
              value: currentCharge,
              onChanged: (String? newValue) {
                setState(() {
                  currentCharge = newValue!;
                });
              },
              items: percentages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Date'),
                    controller: TextEditingController(
                        text: "${selectedDate.toLocal()}".split(' ')[0]),
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Time'),
                    controller: TextEditingController(
                        text: selectedTime.format(context)),
                    onTap: () => _selectTime(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logger.d('Confirm Booking button pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingConfirmationScreen(
                      stationName: widget.stationName,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      date: "${selectedDate.toLocal()}".split(' ')[0],
                      time: selectedTime.format(context),
                      currentCharge: currentCharge,
                    ),
                  ),
                );
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
