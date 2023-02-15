import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vita/Util/fetcher.dart';

import 'package:vita/Widget/TimePicker.dart';

import '../Util/user.dart';

class MedicineInfoArgs {
  final int medicineID;

  MedicineInfoArgs(this.medicineID);
}

class MedicineInfo extends StatefulWidget {
  @override
  _MedicineInfoState createState() => _MedicineInfoState();
}

class _MedicineInfoState extends State<MedicineInfo> {
  var _selectedMedicineType;
  var _randomImg = "assets/medicine2.png";
  final _medicineNameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  var selectedTimeList = [];

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

  _getMedicineInfo(args) async {
    final res = jsonDecode(
        (await Fetcher.fetch('get', '/api/v1/medicine/${args.medicineID}', {}))
            .body);
    setState(() {
      _medicineNameTextController.text = res['name'];
      _selectedMedicineType = res['type'];
      _randomImg = res['thumbnail'];
      selectedTimeList = res['time']
          .map((value) => TimeOfDay(
              hour: int.parse(value.split(':')[0]),
              minute: int.parse(value.split(':')[1])))
          .toList();
      for (var i = 0; i < _isSelectedDays.length; i++) {
        _isSelectedDays[i]['checked'] = res['repeat'][i] == '1';
      }
      _descriptionTextController.text = res['description'];
    });
  }

  _updateMedicineHandler() async {
    final medicineId =
        (ModalRoute.of(context)!.settings.arguments as MedicineInfoArgs)
            .medicineID;
    final userId = await User.getUserId();
    final res = Fetcher.fetch(
        'patch',
        '/api/v1/medicine/$medicineId',
        jsonEncode({
          "name": _medicineNameTextController.text,
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
  }

  _deleteMedicineHandler() async {
    final medicineId =
        (ModalRoute.of(context)!.settings.arguments as MedicineInfoArgs)
            .medicineID;
    final res = await Fetcher.fetch(
        'delete', '/api/v1/medicine/$medicineId', jsonEncode({}));
    return res.body;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)!.settings.arguments as MedicineInfoArgs;
      _getMedicineInfo(args);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("약 정보 수정"),
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
                controller: _medicineNameTextController,
                decoration: const InputDecoration(
                  hintText: '약의 이름을 적어주세요.',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    _medicineNameTextController.text = value;
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
              TimePicker(selectedTime: selectedTimeList[i], index: i)
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
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    "돌아가기",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    // fetch to server with medicine data
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('정말 삭제하시겠어요?'),
                          content: const Text('등록된 약 정보가 삭제됩니다.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('돌아가기'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('삭제하기'),
                              onPressed: () async {
                                final res = await _deleteMedicineHandler();
                                Navigator.of(context).pop(res);
                                Navigator.of(context).pop(res);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    "삭제하기",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () async {
                    await _updateMedicineHandler();
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    "변경하기",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        )),
      ),
    );
  }
}
