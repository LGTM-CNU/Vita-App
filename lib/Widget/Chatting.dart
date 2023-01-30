import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChattingWidget extends StatefulWidget {
  @override
  _ChattingWidgetState createState() => _ChattingWidgetState();
}

class _ChattingWidgetState extends State<ChattingWidget>{

  void prefClear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context){
    return (
      Container(
        child:
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
          )
      )
    );
  }
}