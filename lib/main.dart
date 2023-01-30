import 'package:flutter/material.dart';

import 'package:vita/Screen/NewMedicine.dart';
import 'package:vita/Screen/Login.dart';
import 'package:vita/Screen/Main.dart';
import 'package:vita/Screen/Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vita',
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/new_medicine': (context) => NewMedicine(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}