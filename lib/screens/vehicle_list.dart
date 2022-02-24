import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/screens/vehicle_info.dart';
import '../models/vehicle.dart';
import 'package:http/http.dart' as http;

class CarList extends StatelessWidget {
  const CarList();

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

class VehiclesList extends StatelessWidget {
  const VehiclesList({Key? key, required this.vehicles}) : super(key: key);

  final List<Vehicle> vehicles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 180,
      ),
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        return _FeatureItem(vehicles[index].plate, vehicles[index].description, onClick: VehicleInfo(vehicles[index]),);
      },
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String plate;
  final String description;
  final Function onClick;

  _FeatureItem(this.plate, this.description, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: 60,
            width: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Placa:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
                Text(plate,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      letterSpacing: 3.0,
                    )),
                Text('Descrição: ' + description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
