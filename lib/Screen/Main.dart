import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vita/Widget/bottomNavigationBar.dart';
import 'package:vita/Widget/Chatting.dart';
import 'package:vita/Widget/Medicine.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool('isLogin');

    print("===== in main page=======");
    print(value);

    if (value != null && !value) Navigator.of(context).pushNamed('/login');
  }

  @override
  void initState() {
    super.initState();

    _checkLogin();
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
        appBar: AppBar(
            title: Text("Hello Vita")
      ),
      bottomNavigationBar: BottomNavigationBars(),
    );
  }
}
