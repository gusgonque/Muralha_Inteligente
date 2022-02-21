//TODO: notificação de acordo com a distância do carro. https://pub.dev/packages/flutter_local_notifications

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
                point: new LatLng(_latitude, _longitude),
                builder: (ctx) =>
                  new Container(
                    child: Image.asset('lib/images/carro.png'),
                    //TODO: Fazer um widget que faz o ícone do carro.
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
              markerSize: const Size(10, 10),
              accuracyCircleColor: Colors.blue.withOpacity(0.1),
              headingSectorColor: Colors.blue.withOpacity(0.8),
              headingSectorRadius: 100,
              markerAnimationDuration: Duration.zero, // disable animation
            ),
          ),
        ],
      ),
    );
  }
}
