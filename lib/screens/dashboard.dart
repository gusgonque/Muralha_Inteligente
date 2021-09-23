import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/screens/car_add.dart';
import 'package:muralha_inteligente_app/screens/car_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('lib/images/logo.png'),
          ),
          Row(
            children: [
              _FeatureItem(
                'Lista de\nVeículos suspeitos',
                Icons.list,
                onClick: () {
                  _showCarList(context);
                },
              ),
              _FeatureItem('Adicionar\nVeículo suspeito', Icons.add,
                  onClick: () {
                _showCarAdd(context);
              }),
            ],
          ),
        ],
      ),
    );
  }
}

void _showCarList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CarList(),
    ),
  );
}

void _showCarAdd(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CarAdd(),
    ),
  );
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(this.name, this.icon, {required this.onClick});

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
            width: 180,
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
