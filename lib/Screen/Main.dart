import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vita/Widget/bottomNavigationBar.dart';
import 'package:vita/Widget/Chatting.dart';
import 'package:vita/Widget/Medicine.dart';

import 'Login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool('isLogin');

    if (value != null && !value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();

    _checkLogin();
    Permission.notification.request();
  }

  final List<Widget> _widgetOptions = <Widget>[
    MedicineWidget(),
    ChattingWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      appBar: AppBar(title: Text("Hello Vita")),
      bottomNavigationBar: BottomNavigationBars(),
    );
  }
}
