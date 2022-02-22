import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muralha_inteligente_app/screens/vehicle_add.dart';
import 'package:muralha_inteligente_app/screens/vehicle_list.dart';
import 'package:muralha_inteligente_app/screens/map.dart';

Future<Position> _determinePosition(context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text("O aplicativo não tem acesso a localização do dispositivo.\nVocê não conseguirá utilizar os recursos do aplicativo desse modo.\nPor favor, ative a localização manualmente."),
          );
        },
      );
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text("O aplicativo não tem acesso a localização do dispositivo.\nVocê não conseguirá utilizar os recursos do aplicativo desse modo.\nPor favor, ative a localização manualmente."),
        );
      },
    );
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _determinePosition(context);
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
                  _FeatureItem('Mapa', Icons.map,
                      onClick: () {
                        _map(context);
                      }),
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

void _map(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Map(),
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
            width: 110,
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
