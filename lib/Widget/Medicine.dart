import 'package:flutter/material.dart';

class MedicineWidget extends StatefulWidget {
  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget>{
  @override
  Widget build(BuildContext context){
    return (
      Container(
        margin: EdgeInsets.only(top: 120),
        child: ElevatedButton(
          child: Text('go to login from medicine'),
          onPressed: () {
            print("go back");
            Navigator.of(context).pushNamed('/login');
          },
        ),
      )
    );
  }
}