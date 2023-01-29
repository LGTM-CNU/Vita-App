import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Widget/bottomNavigationBar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Hello Vita")
      ),
      bottomNavigationBar: BottomNavigationBars(),
    );
  }
}
