import 'package:flutter/material.dart';

import 'package:vita/Widget/MedicineCard.dart';

class MedicineWidget extends StatefulWidget {
  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  final _medicines = [
    {'title': "비타민 C", 'thumbnail': 'assets/medicine1.png', 'type': "건강 보조 식품"},
    {'title': "비타민 D", 'thumbnail': 'assets/medicine2.png', 'type': "건강 보조 식품"},
    {'title': "비타민 Z", 'thumbnail': 'assets/medicine3.png', 'type': "보노보노 식품"},
  ];

  @override
  Widget build(BuildContext context) {
    return (Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background.png'),
          repeat: ImageRepeat.repeat,
          opacity: 0.7,
        )),
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Wrap(
                      runSpacing: 20.0,
                      spacing: 20.0,
                      children: [
                        for (var i = 0; i < _medicines.length; i++) ...[
                          MedicineCard(
                            medicineID: i,
                            title: _medicines[i]['title'] as String,
                            color: i % 4 == 1 || i % 4 == 2
                                ? 0xfff8d1af
                                : 0xfffdf4d7,
                            thumbnail: _medicines[i]['thumbnail'] as String,
                            type: _medicines[i]['type'] as String,
                          )
                        ],
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/new_medicine');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                                width: 150,
                                height: 160,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.7,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Color(
                                      4 % 4 == 1 || _medicines.length % 4 == 2
                                          ? 0xfff8d1af
                                          : 0xfffdf4d7),
                                ),
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "새로운 약\n"
                                      "등록하기",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ))),
                          ),
                        )
                      ],
                    ))))));
  }
}
