import 'package:flutter/material.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage>{
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
                    child: Text('go to login from medicine'),
                    onPressed: () {
                      print("go back");
                      Navigator.of(context).pushNamed('/login');
                    },
                  ),
                ),
              ],
            ),
        )
    );
  }
}