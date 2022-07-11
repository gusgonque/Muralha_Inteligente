import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class ShowMap extends StatelessWidget {
  final double lat;
  final double long;
  ShowMap(this.lat, this.long);
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        //center: LatLng(-14.2400732, -53.1805017), // coordernadas do Brasil
        center: new LatLng(lat, long),
        zoom: 10,
        maxZoom: 19,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      layers: [
        MarkerLayerOptions(
          markers: [
            new Marker(
              width: 10.0,
              height: 10.0,
              point: new LatLng(lat, long),
              builder: (ctx) => new Container(
                child: Image.asset('lib/images/carro.png'),
                //TODO: * Melhorar o ícone do carro. ?
              ),
            ),
          ],
        ),
      ],
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            maxZoom: 19,
          ),
        ),
        LocationMarkerLayerWidget(
          options: LocationMarkerLayerOptions(
            marker: const DefaultLocationMarker(
              color: Colors.blue,
            ),
            markerSize: const Size(15, 15),
            accuracyCircleColor: Colors.blue.withOpacity(0.1),
            headingSectorColor: Colors.blue.withOpacity(0.5),
            headingSectorRadius: 100,
            markerAnimationDuration: Duration.zero, // disable animation
          ),
        ),
      ],
    );
  }
}

//Determine actual position
Future<Position> determinePosition(context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (!serviceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("O aplicativo não tem acesso a localização do dispositivo.\nVocê não conseguirá utilizar os recursos do aplicativo desse modo.\nPor favor, ative a localização manualmente."),
          );
        },
      );
      print('Location permissions are denied');
    }
  }

  return await Geolocator.getCurrentPosition();
}

// Determine distance between a point and the last know location.
Future<double> determineDistance(double lat, double long) async {
  Position? position = await Geolocator.getLastKnownPosition();

  print('lat: ${position?.latitude}');

  double distance = Geolocator.distanceBetween(position?.latitude ?? 0, position?.longitude ?? 0, lat, long);
  var distanceInKm = (distance / 1000);
  print('Distance is: $distanceInKm');
  return distanceInKm;
}