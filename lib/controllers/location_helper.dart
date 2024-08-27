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
      // Handle the case when location data is not available
      print("Location data is not available.");
      return;
    }

    double latitude = locationData.first!;
    double longitude = locationData.last!;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    ).timeout(const Duration(seconds: 20));

    UserLocation.lat = latitude;
    UserLocation.long = longitude;
    UserLocation.country = placemarks[0].country ?? '';
    UserLocation.city = placemarks[0].locality ?? placemarks[0].street ?? '';
    UserLocation.street = placemarks[0].street ?? '';
    UserLocation.region = placemarks[0].administrativeArea ??
        placemarks[0].subAdministrativeArea ??
        '';
  } catch (e) {
    print("Error getting location or address: $e");
  }
}
