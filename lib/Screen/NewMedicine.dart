import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vita/Util/fetcher.dart';

import 'package:vita/Widget/TimePicker.dart';

import '../Util/user.dart';

class NewMedicine extends StatefulWidget {
  @override
  NewMedicineState createState() => NewMedicineState();
}

class NewMedicineState extends State<NewMedicine> {
  var _selectedMedicineType;
  var _medicineName = '';
  var _randomImg = '';
  final _descriptionTextController = TextEditingController();

  var selectedTimeList = [];

  final _medicineImg = [
    "assets/medicine1.png",
    "assets/medicine2.png",
    "assets/medicine3.png",
    "assets/medicine4.png"
  ];

  final _isSelectedDays = [
    {'day': '일', 'checked': false},
    {'day': '월', 'checked': false},
    {'day': '화', 'checked': false},
    {'day': '수', 'checked': false},
    {'day': '목', 'checked': false},
    {'day': '금', 'checked': false},
    {'day': '토', 'checked': false},
  ];

  final _medicineTypes = [
    '영양제',
    '감기약',
    '해열 진통 소염제',
    '피부약',
    '연고',
    '신경 정신과',
    '한약',
    '기타'
  ];

  _medicineRegisterHandler() async {
    final userId = await User.getUserId();
    final res = await Fetcher.fetch(
        'post',
        '/api/v1/medicine',
        jsonEncode({
          "name": _medicineName,
          "type": _selectedMedicineType,
          "description": _descriptionTextController.text,
          "thumbnail": _randomImg,
          "userId": userId,
          "time": selectedTimeList
              .map((value) => "${value.hour}:${value.minute}")
              .toList(),
          "repeat": _isSelectedDays.fold("", (prev, element) {
            return element['checked'] == true ? "${prev}1" : "${prev}0";
          }),
        }));
    return res.body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final random = Random();
    setState(() {
      _randomImg = _medicineImg[random.nextInt(4)];
    });
  }

  @override
  void dispose() {
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("약 등록 하기"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(_randomImg),
                  ))),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: 200,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '약의 이름을 적어주세요.',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    _medicineName = value;
                  });
                },
              ),
            ),
            DropdownButton<String>(
              hint: const Text('약 종류를 선택해주세요.'),
              value: _selectedMedicineType,
              items: [
                for (var medicine in _medicineTypes) ...[
                  DropdownMenuItem(
                    value: medicine,
                    child: Text(medicine),
                  )
                ]
              ],
              onChanged: (value) {
                setState(() {
                  _selectedMedicineType = value;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _descriptionTextController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "약에 대한 설명을 적어주세요.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            for (var i = 0; i < selectedTimeList.length; i++) ...[
              TimePicker(
                  selectedTime: selectedTimeList[i],
                  index: i,
                  deleteTimeHandler: () {
                    setState(() {
                      selectedTimeList.removeAt(i);
                    });
                  })
            ],
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedTimeList.add(TimeOfDay.now());
                });
              },
              child: const Text(
                "알림 시간 추가",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Text('약을 드셔야하는 요일을 선택해주세요.',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  Row(
                    children: <Widget>[
                      for (var i = 0; i < _isSelectedDays.length; i++) ...[
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _isSelectedDays[i]['checked'] =
                                        !(_isSelectedDays[i]['checked']
                                            as bool);
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      _isSelectedDays[i]['checked'] == true
                                          ? Colors.orange
                                          : Colors.white,
                                  side: const BorderSide(
                                      color: Colors.grey, width: 1),
                                ),
                                child: Text(
                                  _isSelectedDays[i]['day'] as String,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          _isSelectedDays[i]['checked'] == true
                                              ? Colors.white
                                              : Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ))
                      ]
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    "돌아가기",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () async {
                    final res = await _medicineRegisterHandler();
                    Navigator.of(context).pop(res);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    "등록하기",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Container(
              height: 50,
            )
          ],
        )),
      ),
    );
  }
}
