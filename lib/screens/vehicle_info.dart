import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/models/vehicle.dart';
import 'map.dart';

class VehicleInfo extends StatelessWidget {
  final Vehicle vehicle;

  VehicleInfo(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  'Placa: ' + vehicle.plate,
                  style: TextStyle(
                    fontSize: 18,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  'Descrição: ' + vehicle.description,
                  style: TextStyle(
                    fontSize: 18,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                height: 500,
                width: 160,
                child: ShowMap(vehicle.latitude, vehicle.longitude),
              ),
            ),

          ],
        ),
      ),
    );
  }
}