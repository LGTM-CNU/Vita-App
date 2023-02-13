import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:vita/Screen/MedicineInfo.dart';
import 'package:vita/Screen/NewMedicine.dart';
import 'package:vita/Screen/Login.dart';
import 'package:vita/Screen/Main.dart';
import 'package:vita/Screen/Splash.dart';
import 'package:vita/generated/l10n.dart';

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
      localizationsDelegates: const [
        S.delegate, // Add this line!
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ko', ''),
      ],
      title: 'Vita',
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/new_medicine': (context) => NewMedicine(),
        '/medicine_info': (context) => MedicineInfo(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
