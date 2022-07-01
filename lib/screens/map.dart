import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/controller/mapController.dart';

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