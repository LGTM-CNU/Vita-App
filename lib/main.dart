import 'package:flutter/material.dart';

import './LoginScreen.dart';
import './MainScreen.dart';
import './SplashScreen.dart';

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
        '/login': (context) => LoginPage(),
        '/main': (context) => MainPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}