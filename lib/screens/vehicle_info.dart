import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/models/vehicle.dart';

// ?? Mudar texto para botão de localização.

class VehicleInfo extends StatefulWidget {
  @override
  _VehicleInfoState createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  final Vehicle vehicle;

  _VehicleInfoState(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'Típo do veículo',
                ),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {
                      final String placa = _plate.text;
                      final String descricao = _description.text;
                      //return Car(placa,descricao);
                    },
                    child: Text('Adicionar')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
