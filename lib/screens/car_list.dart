//TODO: *** Fazer essa lista funcionar. Back-end, servidor https://docs.flutter.dev/cookbook/networking/send-data

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}
class _CarListState extends State<CarList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veículos suspeitos'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                'ABC1234',
                style: TextStyle(fontSize: 24.0),
              ),
              subtitle: Text(
                'Carro 1',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
