import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:vita/Screen/Main.dart';
import 'package:vita/Util/fetcher.dart';

import '../Util/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";

  void _loadIsLogin() async {
    var value = await User.getIsLogin();

    if (value != null && value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    }
  }

  void _loginHandler() async {
    final res = await Fetcher.fetch('get', '/api/v1/user/$_username', {});

    print(res);
    if (res == null) return;
    print(
        'login :: ${json.decode(res.body)['id']} :: ${json.decode(res.body)['mode']}');
    User.setIsLogin(res.statusCode == 200);
    User.setUserId(json.decode(res.body)['id']);
    User.setUserMode(json.decode(res.body)['mode']);

    final fcmToken = await FirebaseMessaging.instance.getToken();
    await Fetcher.fetch('post', '/api/v1/push-message/fcm',
        jsonEncode({"user_id": _username, "fcmToken": fcmToken}));

    await Navigator.pushReplacement(
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
      appBar: AppBar(title: const Text("로그인")),
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
