import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final Logger _logger = Logger();

class BlynkService {
  final String url;

  BlynkService({required this.url});

  Future<double> getAmount() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return double.parse(response.body);
      } else {
        throw Exception('Failed to load amount from Blynk');
      }
    } catch (e) {
      _logger.e('Error fetching data: $e');
      throw Exception('Failed to load amount from Blynk');
    }
  }
}
