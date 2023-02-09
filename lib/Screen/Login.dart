import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vita/Screen/Main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";

  void _loadIsLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool('isLogin');

    if (value != null && value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    }
  }

  void _loginHandler() async {
    // check id, pw
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
  }

  @override
  void initState() {
    super.initState();

    _loadIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
            child: TextField(
              decoration: const InputDecoration(
                labelText: '사용자 아이디',
                hintText: '아이디를 입력해주세요.',
              ),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
            child: TextField(
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력해주세요.',
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: const Text('로그인'),
              onPressed: () {
                // Sign in logic here
                _loginHandler();
              },
            ),
          ),
        ],
      ),
    );
  }
}
