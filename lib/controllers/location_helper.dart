import 'dart:async';

import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'user_location.dart'; // Import your UserLocation class

Future<Set<double?>> locationService() async {
  final loc.Location location = loc.Location();
  bool serviceEnabled;
  loc.PermissionStatus permissionLocation;
  loc.LocationData locData;

  try {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return {};
      }
    }

    permissionLocation = await location.hasPermission();
    if (permissionLocation == loc.PermissionStatus.denied) {
      permissionLocation = await location.requestPermission();
      if (permissionLocation != loc.PermissionStatus.granted) {
        return {};
      }
    }

    locData = await location.getLocation();
    return {locData.latitude, locData.longitude};
  } catch (e) {
    print("Error retrieving location: $e");
    return {};
  }
}

Future<void> getUserLocation() async {
  try {
    final locationData = await locationService();
    if (locationData.isEmpty) {
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
        rethrow; // Rethrow if it's the last attempt
      }
      print("Timeout occurred, retrying... (attempt ${attempt + 1})");
    } on PlatformException catch (e) {
      if (attempt == retries - 1) {
        rethrow; // Rethrow if it's the last attempt
      }
      print(
          "PlatformException: ${e.message}. Retrying... (attempt ${attempt + 1})");
    } catch (e) {
      // Handle other types of exceptions if necessary
      if (attempt == retries - 1) {
        rethrow; // Rethrow if it's the last attempt
      }
      print(
          "An unexpected error occurred: $e. Retrying... (attempt ${attempt + 1})");
    }
    await Future.delayed(
        const Duration(seconds: 2)); // Optional delay between retries
  }
  return []; // Return an empty list if all retries fail
}
