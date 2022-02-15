//TODO: notificação de acordo com a distância do carro.

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 1,
          maxZoom: 19,
        ),
        layers: [
          MarkerLayerOptions(
            markers: [
              new Marker(
                width: 10.0,
                height: 10.0,
                point: new LatLng(-25.516592, -54.585251),
                builder: (ctx) =>
                  new Container(
                    child: new FlutterLogo(),
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
                color: Colors.green,
              ),
              markerSize: const Size(10, 10),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: 100,
              markerAnimationDuration: Duration.zero, // disable animation
            ),
          ),
        ],
      ),
    );
  }
}
