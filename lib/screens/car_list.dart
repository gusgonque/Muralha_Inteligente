import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
