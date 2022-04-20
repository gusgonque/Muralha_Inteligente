import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notificationsPlugin.initialize(initializationSettings);
  }

  //=================================================
  //==============this is the update notification

  static Future<void> showProgressNotification() async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('progress channel', 'progress channel',
            channelDescription: 'progress channel description',
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            playSound: false,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i);
        final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        await _notificationsPlugin.show(
            0,//I use this id to cancel it from below method
            'progress notification title',
            'progress notification body',
            platformChannelSpecifics,
            payload: 'item x');
      });
    }
  }

  //=========================and this is for the ProgressNotification to be cancelled
  static Future<void> cancelNotification() async {
    await _notificationsPlugin.cancel(0);
  }

}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

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
  } else {
    print("NÃO NOTIFICAR.");
    await LocalNotificationService.showProgressNotification();
    await Future<void>.delayed(const Duration(seconds: 2));//faking task delay
    await LocalNotificationService.cancelNotification();//by default I have made id=0
  }
}