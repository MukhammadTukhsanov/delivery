import 'dart:async';

import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_location.dart'; // Import your UserLocation class

Future<Set<double?>> locationService() async {
  final loc.Location location = loc.Location();
  bool _serviceEnabled;
  loc.PermissionStatus _permissionLocation;
  loc.LocationData _locData;

  try {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return {};
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == loc.PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != loc.PermissionStatus.granted) {
        return {};
      }
    }

    _locData = await location.getLocation();
    return {_locData.latitude, _locData.longitude};
  } catch (e) {
    print("Error retrieving location: $e");
    return {};
  }
}

Future<void> getUserLocation() async {
  try {
    final locationData = await locationService();
    if (locationData == null || locationData.isEmpty) {
      print("Location data is not available.");
      return;
    }

    double? latitude = locationData.first;
    double? longitude = locationData.last;

    if (latitude == null || longitude == null) {
      print("Failed to retrieve valid location coordinates.");
      return;
    }

    try {
      List<Placemark> placemarks =
          await _retryPlacemarkFromCoordinates(latitude, longitude, 3);
      print('placemarks ${placemarks[1]}');
      if (placemarks.isNotEmpty) {
        UserLocation.lat = latitude;
        UserLocation.long = longitude;
        UserLocation.country = placemarks[1].country ?? '';
        // UserLocation.city =
        //     placemarks[1].locality ?? placemarks[1].street ?? '';
        UserLocation.street = placemarks[1].thoroughfare ?? '';
        UserLocation.locality = placemarks[1].locality ?? '';
        UserLocation.region = placemarks[1].administrativeArea ??
            placemarks[1].subAdministrativeArea ??
            '';
        UserLocation.place = placemarks[1].street ?? '';
      } else {
        print("Could not retrieve address information.");
      }
    } catch (e) {
      print("Error getting location or address: $e");
    }
  } catch (e) {
    print("Error getting location or address: $e");
  }
}

Future<List<Placemark>> _retryPlacemarkFromCoordinates(
    double latitude, double longitude, int retries) async {
  for (int attempt = 0; attempt < retries; attempt++) {
    try {
      return await placemarkFromCoordinates(latitude, longitude)
          .timeout(const Duration(seconds: 60));
    } on TimeoutException {
      if (attempt == retries - 1) {
        rethrow;
      }
      print("Retrying reverse geocoding... (attempt ${attempt + 1})");
    }
  }
  return []; // Return an empty list if all retries fail
}
