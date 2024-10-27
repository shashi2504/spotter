import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:testing/bookmark_screen.dart';
import 'chargingstation_details.dart';
import 'dart:math' as math;
import 'trips_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final logger = Logger();

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({super.key});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  List<ChargingStation> chargingStations = [
    ChargingStation("AB-II Model X", const LatLng(10.9041707, 76.898001)),
    ChargingStation("VMB Model C1", const LatLng(10.901449, 76.905746)),
    ChargingStation(
        "Ettimadai Charging Station", const LatLng(10.8977847, 76.8951039)),
    ChargingStation(
        "Madukkarai Easy Charge Station", const LatLng(10.9151433, 76.9486759)),
    ChargingStation(
        "PowerUp Plus Station: Model X", const LatLng(10.9901585, 76.9188049)),
    ChargingStation(
        "ChargeHub Elite: Model 3", const LatLng(10.9614884, 76.9861954)),
    ChargingStation(
        "SwiftCharge Pro: Model Y2", const LatLng(10.9502784, 76.9534152)),
    ChargingStation(
        "TurboCharge Station: Model B2", const LatLng(10.9281852, 76.9499038)),
  ];

  final LatLng _center = const LatLng(10.9039982, 76.8980172);

  final Location location = Location();
  Set<Polyline> polylines = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    _subscribeToLocationChanges();
  }

  Future<void> _subscribeToLocationChanges() async {
    location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        currentLocation = locationData;
      });
    });
  }

  Future<void> _getLocation() async {
    try {
      var locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
      });
    } catch (e) {
      logger.e("Error getting location: $e");
    }
  }

  void _onChargingStationTapped(
      String stationName, String address, String chargerType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChargingStationDetailsScreen(
          stationName: stationName,
          address: address,
          chargerType: chargerType,
        ),
      ),
    );
  }

  void _zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  void _repositionToCurrentLocation() {
    if (currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        ),
      );
    }
  }

  Marker _createChargingStationMarker(
      String markerId, LatLng position, String title, String snippet) {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
      onTap: () {
        _onChargingStationTapped(
            title, "VVXW+429 Ettimadai Tamil Nadu", "CCS-2");
      },
    );
  }

  Set<Marker> _createMarkers() {
    return {
      for (var station in chargingStations)
        _createChargingStationMarker(
          station.name,
          station.position,
          station.name,
          "Tap for details",
        ),
    };
  }

  List<ChargingStation> _getNearbyChargingStations() {
    const double maxDistance = 5.0;
    List<ChargingStation> nearbyStations = [];

    for (var station in chargingStations) {
      double distance = _calculateDistance(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        station.position.latitude,
        station.position.longitude,
      );

      if (distance <= maxDistance) {
        nearbyStations.add(station);
      }
    }

    return nearbyStations;
  }

  double _calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const int earthRadius = 6371;
    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLongitude - startLongitude);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(startLatitude)) *
            math.cos(_degreesToRadians(endLatitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  void _showChargingStationsList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        List<ChargingStation> nearbyStations = _getNearbyChargingStations();

        return Column(
          children: [
            const ListTile(
              title: Text('Nearby Charging Stations'),
              subtitle: Text('Tap to view details'),
            ),
            for (var station in nearbyStations)
              ListTile(
                title: Text(station.name),
                subtitle: Text(
                  'Address: ${station.address}\nDistance: ${_calculateDistance(currentLocation!.latitude!, currentLocation!.longitude!, station.position.latitude, station.position.longitude).toStringAsFixed(2)} km\nPlug Type: ${station.plugType}',
                ),
                onTap: () {
                  _onChargingStationTapped(
                    station.name,
                    station.address,
                    station.plugType,
                  );
                  _showRoute(station.position);
                  Navigator.pop(context);
                },
              ),
          ],
        );
      },
    );
  }

  void _showRoute(LatLng destination) async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation!.latitude},${currentLocation!.longitude}&destination=${destination.latitude},${destination.longitude}&key=YOUR_APPI_KEY';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<LatLng> routeCoords =
          _decodePoly(data['routes'][0]['overview_polyline']['points']);

      setState(() {
        polylines.clear();
        polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.blue,
          width: 5,
          points: routeCoords,
        ));
      });
    } else {
      throw Exception('Failed to load route');
    }
  }

  List<LatLng> _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <LatLng>[];

    int index = 0;
    int len = poly.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = list[index++] - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = list[index++] - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      lList.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return lList;
  }

  void _navigateToBookmarkScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookmarkScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Spotter',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 4, 51, 97),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: IconButton(
                onPressed: () {
                  _showSearchBar();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _createMarkers(),
              polylines: polylines,
            ),
            Positioned(
              top: 450,
              right: 7,
              child: FloatingActionButton(
                onPressed: _repositionToCurrentLocation,
                tooltip: 'Reposition to Current Location',
                child: const Icon(Icons.location_searching),
              ),
            ),
            Positioned(
              top: 200,
              right: 5,
              child: Column(
                children: [
                  IconButton(
                    onPressed: _zoomIn,
                    icon: const Icon(Icons.zoom_in),
                  ),
                  IconButton(
                    onPressed: _zoomOut,
                    icon: const Icon(Icons.zoom_out),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: _showChargingStationsList,
                      icon: const Icon(Icons.list),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.explore),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TripsScreen()),
                        );
                      },
                      icon: const Icon(Icons.directions),
                    ),
                    IconButton(
                      onPressed: _navigateToBookmarkScreen,
                      icon: const Icon(Icons.bookmark),
                      color: _isOnBookmarkScreen() ? Colors.orange : null,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChargingStation {
  final String name;
  final LatLng position;
  final String address;
  final String plugType;

  ChargingStation(this.name, this.position,
      {this.address = "", this.plugType = ""});
}

void _showSearchBar() {}

bool _isOnBookmarkScreen() {
  return false;
}
