import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/controller/mapController.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final String topic = 'todos';

int createUniqueID(int maxValue) {
  Random random = new Random();
  return random.nextInt(maxValue);
}

Future<void> startNotificationHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('token = $token');

  messaging.subscribeToTopic(topic);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('mensagem recebida em foreground');
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  AwesomeNotifications().actionStream.listen((event) {
    print('event received!');
    print(event.toMap().toString());
    //TODO: desobrir como abrir a tela

  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  int id = createUniqueID(10000);
  double distanceInKm = await determineDistance(
      double.parse(message.data["lat"]), double.parse(message.data["long"]));

  if (distanceInKm <= 5)
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: 'VEÍCULO SUSPEITO EM SUA ÁREA!',
            body:
                '${message.data["description"]} de placa ${message.data["plate"]}. Clique aqui para mais informações.',
            wakeUpScreen: true),
        actionButtons: [
          NotificationActionButton(key: 'key', label: 'label'),
        ]);

}

listenActionStream() {
  AwesomeNotifications().actionStream.listen((receivedAction) {
    var payload = receivedAction.payload;

    if (receivedAction.channelKey == 'normal_channel') {
      //do something here
    }
  });
}
