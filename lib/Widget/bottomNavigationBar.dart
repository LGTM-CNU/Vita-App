import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vita/Screen/Login.dart';
import 'package:vita/Screen/Main.dart';

class BottomNavigationBars extends StatefulWidget {
  @override
  _BottomNavigationBarsState createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  void _onItemTapped(int index) {
    // 개발 모드 예외처리
    if (index == 2) {
      SharedPreferences.getInstance().then((pref) {
        pref.setBool('isLogin', false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      });
      return;
    }
    MainScreenState? parentState =
        context.findAncestorStateOfType<MainScreenState>();
    if (parentState == null) return;
    parentState.setState(() {
      parentState.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainScreenState? parentState =
        context.findAncestorStateOfType<MainScreenState>();

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_information),
          label: 'Medicine',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chatting',
        ),
        if (kDebugMode)
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          )
      ],
      currentIndex: parentState == null ? 0 : parentState.selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
