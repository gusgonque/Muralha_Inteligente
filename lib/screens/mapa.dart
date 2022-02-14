import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
// TODO: fazer o marker para marcar uma área

Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 400,
            height: 400,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-25.516592, -54.585251),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

