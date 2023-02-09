import 'package:flutter/material.dart';

import 'package:vita/Screen/NewMedicine.dart';
import 'package:vita/Screen/Login.dart';
import 'package:vita/Screen/Main.dart';
import 'package:vita/Screen/Splash.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/main': (context) => const MainScreen(),
        '/new_medicine': (context) => NewMedicine(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
