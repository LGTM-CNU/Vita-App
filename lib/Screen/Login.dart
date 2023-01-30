import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  bool _isManager = false;

  void _loadIsLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool('isLogin');

    print("===== in login =======");
    print(value);

    if (value != null && value) Navigator.of(context).pushNamed('/main');
  }

  void _loginHandler() async {
    // check id, pw
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', true);
    Navigator.of(context).pushNamed('/main');
  }

  @override
  void initState() {
    super.initState();

    _loadIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Hello Vita")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 50, right: 50),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
              ),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 50, right: 50),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
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
            child: Switch(
              value: _isManager,
              onChanged: (value) {
                setState(() {
                  _isManager = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: Text('Sign in'),
              onPressed: () {
                // Sign in logic here
                print("check user");
                _loginHandler();
              },
            ),
          ),
        ],
      ),
    );
  }
}
