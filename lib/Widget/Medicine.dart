import 'package:flutter/material.dart';
import 'package:vita/Widget/MedicineCard.dart';

class MedicineWidget extends StatefulWidget {
  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget>{

  final medicines = ["엄준비 1", "엄준비 2", "돌아온 럭키짱"];

  @override
  Widget build(BuildContext context){
    return (
    SafeArea(
      child:
          Padding(
            padding: EdgeInsets.only(top: 30),
            child:
              Align(
                  alignment: Alignment.topCenter,
                  child:
                  Wrap(
                    runSpacing: 20.0,
                    spacing: 20.0,
                    children: [
                      for (var title in medicines)...[
                        MedicineCard(title: title)
                      ]
                    ],
                  )
              )
          )
    )
    );
  }
}