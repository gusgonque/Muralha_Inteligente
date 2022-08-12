import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Determine actual position
Future<Position> determinePosition(context) async {
  await checkPermissionLocation(context);

  return await Geolocator.getCurrentPosition();
}

// check the permissions for location of dispositive.
Future<void> checkPermissionLocation(context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (!serviceEnabled ||
        permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "O aplicativo não tem acesso a localização do dispositivo.\nVocê não conseguirá utilizar os recursos do aplicativo desse modo.\nPor favor, ative a localização manualmente."),
          );
        },
      );
      print('Location permissions are denied');
    }
  }
}

// Determine distance between a point and the last know location.
Future<double> determineDistance(double lat, double long) async {
  Position? position = await Geolocator.getLastKnownPosition();
  print('lat: ${position?.latitude}');
  double distance;

  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();

  // set value
  if (position != null) {
    print('salvando localização');
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('long', position.longitude);
    distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, lat, long);
  } else {
    print('carregando localização');
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('lat') ?? 0;
    final longitude = prefs.getDouble('long') ?? 0;
    distance = Geolocator.distanceBetween(latitude, longitude, lat, long);
  }

  var distanceInKm = (distance / 1000);
  print('Distance is: $distanceInKm');
  return distanceInKm;
}
