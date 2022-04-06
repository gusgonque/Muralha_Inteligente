import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/screens/dashboard.dart';

import 'notifications/notification.dart';
import 'screens/vehicle_list.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    notificationHandler(messaging);
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
    notificationHandler(messaging);
  } else {
    print('User declined or has not accepted permission');
  }

  runApp(MuralhaInteligenteApp());
}

class MuralhaInteligenteApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent[700])
      ),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}


