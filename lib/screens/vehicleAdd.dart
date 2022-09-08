import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muralha_inteligente_app/controller/vehicleController.dart';
import 'package:muralha_inteligente_app/models/vehicleModel.dart';
//todo: camera? https://docs.flutter.dev/cookbook/plugins/picture-using-camera
class VehicleAdd extends StatefulWidget {
  @override
  _VehicleAddState createState() => _VehicleAddState();
}

class _VehicleAddState extends State<VehicleAdd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  static const _errorMessage = 'Campo inválido.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar veículo suspeito'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Placa',
                    ),
                    controller: _plateController,
                    style: TextStyle(fontSize: 24.0),
                    validator: (_textValidator) {
                      if (_textValidator == null || _textValidator.isEmpty) {
                        return _errorMessage;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descrição do veículo',
                      ),
                      controller: _descriptionController,
                      style: TextStyle(fontSize: 24.0),
                      validator: (deviceName) {
                        if (deviceName == null || deviceName.isEmpty) {
                          return _errorMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Será usada a localização atual desse dispositivo.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () async {
                            Position position = await Geolocator.getCurrentPosition();
                            if (_formKey.currentState!.validate()) {
                              insertVehicle(Vehicle(id: 0, plate: _plateController.text, description: _descriptionController.text, latitude: position.latitude, longitude: position.longitude));
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Adicionar')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
