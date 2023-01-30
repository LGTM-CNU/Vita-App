import 'package:flutter/material.dart';

class MedicineCard extends StatefulWidget {
  const MedicineCard({Key? key, required this.title}): super(key: key);
  final String title;

  @override
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard>{

  @override
  Widget build(BuildContext context){
    return (
    Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          width: 150,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text(widget.title)
          )
      ),
    )
    );
  }
}