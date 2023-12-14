import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class LocationService {
  final Location _location = Location();

  Future<bool> requestLocationPermission() async {
    var status = await permission_handler.Permission.location.status;
    if (status != permission_handler.PermissionStatus.granted) {
      status = await permission_handler.Permission.location.request();
    }
    return status == permission_handler.PermissionStatus.granted;
  }

  Future<LocationData?> getCurrentLocation() async {
    if (await requestLocationPermission()) {
      return await _location.getLocation();
    }
    return null;
  }
}
