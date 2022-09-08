import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muralha_inteligente_app/models/vehicleModel.dart';


const String baseURL = 'https://raw.githubusercontent.com/gusgonque/Minhas_Coisas/master/test.json'; //todo: URL server

Future<List<Vehicle>> fetchVehicle(http.Client client) async {
  final response = await client
      .get(Uri.parse(baseURL));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseListVehicle, response.body);
}

List<Vehicle> parseListVehicle(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Vehicle>((json) => Vehicle.fromJson(json)).toList();
}

Future<Vehicle> insertVehicle(Vehicle vehicle) async {
  final response = await http.post(
    Uri.parse(baseURL + '/vehicle/insert'),
    headers: <String, String>{
      'authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTY1ODc1MTkzNSwiZXhwIjoxNjU5MzU2NzM1fQ.YDuh76gSUmsk_ldmwVo0SsfcU33tuzbl7edP4DNUuEc', //todo: token
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'plate': vehicle.plate,
      'description': vehicle.description,
      'latitude': vehicle.latitude,
      'longitude': vehicle.longitude,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    SnackBar(
      content: Text('Veículo adicionado com sucesso!'),
    );
    print('Inserted vehicle');
    return Vehicle.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    SnackBar(
      content: Text('Não foi possível adicionar o veículo!'),
    );
    throw Exception('Failed to insert Vehicle.');
  }
}

Future<Vehicle> updateDevice(Vehicle vehicle) async {
  final response = await http.put(
    Uri.parse(baseURL + '/vehicle/update/' + vehicle.id.toString()),
    headers: <String, String>{
      'authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTY1ODc1MTkzNSwiZXhwIjoxNjU5MzU2NzM1fQ.YDuh76gSUmsk_ldmwVo0SsfcU33tuzbl7edP4DNUuEc', //todo: token
      'content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'plate': vehicle.plate,
      'description': vehicle.description,
      'latitude': vehicle.latitude,
      'longitude': vehicle.longitude,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Vehicle.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to update Device.');
  }
}

Future<Vehicle> removeDevice(Vehicle vehicle) async {
  final response = await http.delete(
    Uri.parse(baseURL + '/vehicle/delete/' + vehicle.id.toString()),
    headers: <String, String>{
      'authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTY1ODc1MTkzNSwiZXhwIjoxNjU5MzU2NzM1fQ.YDuh76gSUmsk_ldmwVo0SsfcU33tuzbl7edP4DNUuEc', //todo: token
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Vehicle.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to remove Device.');
  }
}