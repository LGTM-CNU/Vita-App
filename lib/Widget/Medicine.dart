import 'package:flutter/material.dart';

import 'package:vita/Widget/MedicineCard.dart';
import 'package:vita/Screen/NewMedicine.dart';

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
                      ],
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/new_medicine');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child:
                            Container(
                            width: 150,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("add Medicine")
                            )
                        )),
                      )
                    ],
                  )
              )
          )
    )
    );
  }
}