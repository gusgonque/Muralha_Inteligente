import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'https://raw.githubusercontent.com/gusgonque/Muralha_Inteligente/MuralhaInteligenteGIT/lib/API/test.json?token=GHSAT0AAAAAABRKVZRT2CPVX6RU544GCLKEYQU5TUQ';

class Vehicle {
  final int id;
  final String plate;
  final String description;
  final double latitude;
  final double longitude;

  const Vehicle({required this.id, required this.plate, required this.description, required this.latitude, required this.longitude,});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      plate: json['plate'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

Future<Vehicle> createVehicle(String plate, String description, String latitude, String longitude) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
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

Future<Vehicle> fetchVehicle() async {
  final response = await http.get(
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Vehicle.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Vehicle');
  }
}