import 'package:flutter/material.dart';

import './Screen/Login.dart';
import './Screen/Main.dart';
import './Screen/Splash.dart';

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
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}