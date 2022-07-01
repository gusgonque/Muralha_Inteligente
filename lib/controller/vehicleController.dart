import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:muralha_inteligente_app/models/vehicleModel.dart';


const String url =
    'https://raw.githubusercontent.com/gusgonque/Minhas_Coisas/master/test.json'
;

Future<Vehicle> createVehicle(String plate, String description, double latitude, double longitude) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'plate': plate,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Vehicle.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create Vehicle.');
  }
}

List<Vehicle> parseVehicle(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Vehicle>((json) => Vehicle.fromJson(json)).toList();
}

Future<List<Vehicle>> fetchVehicle(http.Client client) async {
  final response = await client
      .get(Uri.parse(url));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseVehicle, response.body);
}