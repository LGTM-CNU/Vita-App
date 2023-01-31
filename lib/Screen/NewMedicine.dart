import 'package:flutter/material.dart';

class NewMedicine extends StatefulWidget {
  @override
  _NewMedicineState createState() => _NewMedicineState();
}

class _NewMedicineState extends State<NewMedicine> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: const Text("add Medicine")),
      body: const Text("this is add Medicine Screen"),
    ));
  }
}
