import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/controller/mapController.dart';
import 'package:muralha_inteligente_app/models/VehicleListModel.dart';
import 'package:muralha_inteligente_app/screens/map.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    determinePosition(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),
      body: LayoutBuilder(
        builder: (context, contraints) => SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: contraints.maxHeight,
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('lib/images/logo.png'), // TODO: Fazer a logo
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FeatureItem(
                    'Lista\nOnline',
                    Icons.list,
                    onClick: () {
                      _showCarList(context);
                    },
                  ),
                  FeatureItem(
                    'Mapa',
                    Icons.map,
                    onClick: () {
                      _map(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),

    );
  }
}

void _showCarList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => VehicleList(),
    ),
  );
}

void _map(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Map(),
    ),
  );
}

class FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  FeatureItem(this.name, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 120,
            width: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                Text(name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}