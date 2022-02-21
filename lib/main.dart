import 'package:flutter/material.dart';
import 'package:muralha_inteligente_app/screens/dashboard.dart';

void main() => runApp(MuralhaInteligenteApp());

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


