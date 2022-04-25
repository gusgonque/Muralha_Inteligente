import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project


Future<void> startNotificationHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('token = $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print ('mensagem recebida em foreground');
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Mensagem recebida em background"); // : ${message.data}
  Position? position = await Geolocator.getLastKnownPosition();

  double distance = Geolocator.distanceBetween(position?.latitude ?? 0, position?.longitude ?? 0, double.parse(message.data["lat"]), double.parse(message.data["long"]));
  var distanceInKm = (distance / 1000);

  print('Distance is: $distanceInKm');
  if (distanceInKm <= 5) {
    print("NOTIFICAR.");
    await flutterLocalNotificationsPlugin.show(
        0,
        "VEÍCULO SUSPEITO NA SUA ÁREA",
        "Cuidado com o veículo de descrição: ${message.data["body"]}",
        platformChannelSpecifics, //TODO: QUE PORRA É ESSA?
        payload: 'item x');
  } else {
    print("NÃO NOTIFICAR.");
  }
}