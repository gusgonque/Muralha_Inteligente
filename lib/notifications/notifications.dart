import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/controller/mapController.dart';
import 'package:muralha_inteligente_app/main.dart';
import 'package:muralha_inteligente_app/models/vehicleModel.dart';
import 'package:muralha_inteligente_app/screens/vehicleInfo.dart';

final String topic = 'todos';

int createUniqueID(int maxValue) {
  Random random = new Random();
  return random.nextInt(maxValue);
}

Future<void> startNotificationHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('token = $token');

  messaging.subscribeToTopic(topic);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  AwesomeNotifications().actionStream.listen((event) async {
    print('event received!');
    print(event.payload.toString());

    var map = new Map();
    map["id"] = event.payload!["id"];
    map["plate"] = event.payload!["plate"];
    map["description"] = event.payload!["description"];
    map["lat"] = event.payload!["lat"];
    map["lng"] = event.payload!["lng"];

    Vehicle vehicle = new Vehicle(id: int.parse(map["id"]), plate: map["plate"], description: map["description"], latitude: double.parse(map["lat"]), longitude: double.parse(map["lng"]));

    print(vehicle);

    BuildContext context;
    context = navigatorKey.currentContext!;

    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VehicleInfo(vehicle),
        ),
    );



  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  int id = createUniqueID(10000);
  double distanceInKm = await determineDistance(
      double.parse(message.data["lat"]), double.parse(message.data["lng"]));

  var vehicle = {'id': message.data["id"].toString(), 'plate': message.data["plate"].toString(), 'description': message.data["description"].toString(), 'lat': message.data["lat"].toString(), 'lng': message.data["lng"].toString()};

  if (distanceInKm <= 5)
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: 'VEÍCULO SUSPEITO EM SUA ÁREA!',
            body: '${message.data["description"]} de placa ${message.data["plate"]}. Clique aqui para mais informações.',
            payload: vehicle,
            wakeUpScreen: true
        ),
    );


}