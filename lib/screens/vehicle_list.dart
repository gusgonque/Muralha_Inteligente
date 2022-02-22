//TODO: *** Fazer essa lista funcionar. Back-end, servidor https://docs.flutter.dev/cookbook/networking https://docs.flutter.dev/cookbook#lists
import 'package:flutter/material.dart';
import '../models/vehicle.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}
class _CarListState extends State<CarList> {
  late Future<Vehicle> futureVehicle;

  @override
  void initState() {
    super.initState();
    futureVehicle = fetchVehicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de veículos'),
      ),
      body: Center(
        child: FutureBuilder<Vehicle>(
          future: futureVehicle,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.plate);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );

  }
}