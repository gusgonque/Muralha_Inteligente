import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: Mudar texto para botão de localização.

class CarAdd extends StatefulWidget {
  @override
  _CarAddState createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
  final TextEditingController _placaVeiculo = TextEditingController();
  final TextEditingController _descricaoVeiculo = TextEditingController();
  final TextEditingController _localVeiculo = TextEditingController();

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
                controller: _placaVeiculo,
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
                controller: _descricaoVeiculo,
                decoration: InputDecoration(
                  labelText: 'Típo do veículo',
                ),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _localVeiculo,
                decoration: InputDecoration(
                  labelText: 'Localização',
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
                      final String placa = _placaVeiculo.text;
                      final String descricao = _descricaoVeiculo.text;
                      final String local = _localVeiculo.text;
                      //return Car(placa,descricao,local);
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
