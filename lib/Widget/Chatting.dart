import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChattingPage extends StatefulWidget {
  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage>{

  void prefClear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context){
    return (
        Scaffold(
            body:
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 120),
                  child: ElevatedButton(
                    child: Text('go to login from chat'),
                    onPressed: () {
                      print("go login");
                      Navigator.of(context).pushNamed('/login');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120),
                  child: ElevatedButton(
                    child: Text('clear'),
                    onPressed: () {
                      print("pref clear");
                      prefClear();
                    },
                  ),
                ),
              ],
            ),
        )
    );
  }
}