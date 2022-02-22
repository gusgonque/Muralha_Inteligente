import 'package:flutter/material.dart';

//TODO: ?? Mudar texto para botão de localização.

class CarAdd extends StatefulWidget {
  @override
  _CarAddState createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
  final TextEditingController _plate = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar veículo suspeito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _plate,
                decoration: InputDecoration(
                  labelText: 'Placa',
                ),
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
