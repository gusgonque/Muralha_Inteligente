import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> notificationHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken();
  print('token = $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print ('mensagem recebida em foreground');
  });


}