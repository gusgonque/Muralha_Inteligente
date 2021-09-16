import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    (MaterialPageRoute(
                      builder: (context) => CarList(),
                    )),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  height: 120,
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.list,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text('Lista de\nVeículos suspeitos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
