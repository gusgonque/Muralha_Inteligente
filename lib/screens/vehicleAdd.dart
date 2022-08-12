import 'package:flutter/material.dart';

class VehicleAdd extends StatefulWidget {

  @override
  _VehicleAddState createState() => _VehicleAddState();
}

class _VehicleAddState extends State<VehicleAdd> {
  final TextEditingController _plateController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar veículo suspeito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _plateController,
              decoration: InputDecoration(
                labelText: 'Placa',
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição do veículo',
                ),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child:
                ElevatedButton(onPressed: () {
                  final String plate = _plateController.text;
                  final String description = _descriptionController.text;
                  //TODO: localização
                  //TODO: método para adicionar o veículo
                }, child: Text('Adicionar')),
              ),
            )
          ],
        ),
      ),
    );
  }
}