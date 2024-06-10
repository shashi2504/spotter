import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'user_model.dart';

final Logger _logger = Logger();

class FirebaseService {
  // Add this method to save user personal details to Firestore
  static Future<void> savePersonalDetails(
      String name, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc().set({
        'name': name,
        'phoneNumber': phoneNumber,
      });
      _logger.d('User personal details added to Firestore');
    } catch (e) {
      _logger.e('Error adding user personal details to Firestore: $e');
      throw Exception('Failed to save personal details');
    }
  }

  static Future<void> saveVehicleDetails(
      String carMake, String carModel) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc().update({
        'carMake': carMake,
        'carModel': carModel,
      });
      _logger.d('User vehicle details added to Firestore');
    } catch (e) {
      _logger.e('Error adding user vehicle details to Firestore: $e');
      throw Exception('Failed to save vehicle details');
    }
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();
        return User(
          email: data['email'],
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          carMake: data['carMake'],
          carModel: data['carModel'],
        );
      }
      return null;
    } catch (e) {
      _logger.e('Error retrieving user from Firestore: $e');
      return null;
    }
  }

  static isEmailExists(String text) {}
}

Future<bool> isEmailExists(String email) async {
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  } catch (e) {
    _logger.e('Error checking email existence: $e');
    return false;
  }
}
