
import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/controller/vehicleController.dart';
import 'package:muralha_inteligente_app/models/vehicleModel.dart';
import 'package:muralha_inteligente_app/screens/vehicleList.dart';
import 'package:http/http.dart' as http;

class VehicleList extends StatelessWidget {
  const VehicleList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Veículos'),
      ),
      body: FutureBuilder<List<Vehicle>>(
        future: fetchVehicle(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return VehiclesList(vehicles: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
