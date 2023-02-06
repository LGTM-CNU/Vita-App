import 'package:flutter/material.dart';

class NewMedicine extends StatefulWidget {
  @override
  _NewMedicineState createState() => _NewMedicineState();
}

class _NewMedicineState extends State<NewMedicine> {
  bool isRecorderReady = false;
  bool isRecord = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("약 등록 하기"),
      ),
      body: Text("123"),
    );
  }
}
