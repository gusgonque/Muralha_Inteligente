import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

int createUniqueID(int maxValue){
  Random random = new Random();
  return random.nextInt(maxValue);
}

Future<void> startNotificationHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('token = $token');

  messaging.subscribeToTopic('todos');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print ('mensagem recebida em foreground');
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  int id = createUniqueID(10000);
  Position? position = await Geolocator.getLastKnownPosition();

  double distance = Geolocator.distanceBetween(position?.latitude ?? 0, position?.longitude ?? 0, double.parse(message.data["lat"]), double.parse(message.data["long"]));
  var distanceInKm = (distance / 1000);
  print('Distance is: $distanceInKm');

  if(distanceInKm<=5)
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: 'VEÍCULO SUSPEITO EM SUA ÁREA!',
            body: 'Clique aqui para mais informações.',
            wakeUpScreen: true
        ),
    );
  else
    print('Não foi notificado');
}