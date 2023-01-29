import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './MainScreen.dart';
import './LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool('isLogin');

    print("===== in splash =======");
    print(value);

    if (value != null && value) return true;
    return false;
  }

  @override
  void initState() {
    super.initState();
    _checkLogin().then((value) => Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => value != true ? LoginPage() : MainPage()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Splash Screen")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Container()],
      ),
    );
  }
}
