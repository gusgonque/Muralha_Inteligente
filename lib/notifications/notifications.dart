import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

Future<void> startNotificationHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('token = $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print ('mensagem recebida em foreground');
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Position? position = await Geolocator.getLastKnownPosition();

  double distance = Geolocator.distanceBetween(position?.latitude ?? 0, position?.longitude ?? 0, double.parse(message.data["lat"]), double.parse(message.data["long"]));
  var distanceInKm = (distance / 1000);
  print('Distance is: $distanceInKm');

  print("Handling a background message: ${message.messageId}");
  AwesomeNotifications().createNotificationFromJsonData(message.data);

}