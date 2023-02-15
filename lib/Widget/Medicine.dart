import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vita/Util/fetcher.dart';

import 'package:vita/Widget/MedicineCard.dart';

import '../Util/user.dart';

class MedicineWidget extends StatefulWidget {
  @override
  _MedicineWidgetState createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  var _medicines = [];

  _getMedicines() async {
    final userId = await User.getUserId();
    final res = jsonDecode(
        (await Fetcher.fetch('get', '/api/v1/user/$userId/medicines', {}))
            .body);
    setState(() {
      _medicines = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMedicines();
  }

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
                            medicineID: _medicines[i]['id'],
                            title: _medicines[i]['name'] as String,
                            color: i % 4 == 1 || i % 4 == 2
                                ? 0xfff8d1af
                                : 0xfffdf4d7,
                            thumbnail: _medicines[i]['thumbnail'] as String,
                            type: _medicines[i]['type'] as String,
                          )
                        ],
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/new_medicine')
                                .then((res) {
                              if (res == null) return;
                              setState(() {
                                _medicines.add(jsonDecode(res as String));
                              });
                            });
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
