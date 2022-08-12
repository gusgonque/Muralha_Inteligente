import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/models/vehicleModel.dart';
import 'package:muralha_inteligente_app/screens/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'showMap.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FeatureItem('Abrir Rota', Icons.route_rounded, onClick:
                  () {navigateTo(vehicle.latitude, vehicle.longitude);
              }),
            )
          ],
        ),
      ),
    );
  }
}

void navigateTo(double lat, double long) async {
  Uri _url = Uri.parse("google.navigation:q=$lat,$long&mode=d");
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
