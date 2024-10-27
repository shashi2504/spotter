import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testing/payment_screen.dart';
import 'blynk_service.dart';

final Logger _logger = Logger();

class BookingConfirmationScreen extends StatefulWidget {
  final String stationName;
  final String name;
  final String phone;
  final String date;
  final String time;
  final String currentCharge;

  const BookingConfirmationScreen({
    super.key,
    required this.stationName,
    required this.name,
    required this.phone,
    required this.date,
    required this.time,
    required this.currentCharge,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  final TextEditingController _amountController = TextEditingController();
  late BlynkService _blynkService;
  bool _isLoading = true;
  double _amount = 0.0;

  @override
  void initState() {
    super.initState();
    _blynkService = BlynkService(
      url:
          'https://blynk.cloud/external/api/get?token=BLYNK_TOKEN_ID',
    );
    _fetchAmount();
  }

  Future<void> _fetchAmount() async {
    try {
      final amount = await _blynkService.getAmount();
      setState(() {
        _amount = amount;
        _amountController.text = _amount.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _logger.e('Failed to fetch amount: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Station: ${widget.stationName}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Name: ${widget.name}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Phone: ${widget.phone}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Date: ${widget.date}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Time: ${widget.time}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_amountController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                  amount: int.parse(_amountController.text)),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
