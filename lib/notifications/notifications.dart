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

  print("Handling a background message: ${message.messageId}");

  Position? position = await Geolocator.getLastKnownPosition();
  AwesomeNotifications().createNotificationFromJsonData(message.data);

  double distance = Geolocator.distanceBetween(position?.latitude ?? 0, position?.longitude ?? 0, double.parse(message.data["lat"]), double.parse(message.data["long"]));
  var distanceInKm = (distance / 1000);

  print('Distance is: $distanceInKm');
  if (distanceInKm <= 5) {
    print("NOTIFICAR.");
  } else {
    print("NÃO NOTIFICAR.");
    await Future<void>.delayed(const Duration(seconds: 1), () async {
        AwesomeNotifications().cancel(0);
    });
  }
}