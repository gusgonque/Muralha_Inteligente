import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatelessWidget {
  final double _latitude = -25.516592;
  final double _longitude = -54.585251;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: ShowMap(_latitude, _longitude),
    );
  }
}
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
              width: 13.0,
              height: 13.0,
              point: new LatLng(lat, long),
              builder: (ctx) => new Container(
                child: const DefaultLocationMarker(
                  color: Colors.red,
                ),
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