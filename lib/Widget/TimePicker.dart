import 'package:flutter/material.dart';

import 'package:vita/Screen/NewMedicine.dart';
import 'package:vita/Screen/MedicineInfo.dart';

class TimePicker extends StatefulWidget {
  final selectedTime;
  final index;
  final deleteTimeHandler;

  const TimePicker(
      {super.key,
      required this.selectedTime,
      required this.index,
      required this.deleteTimeHandler});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  Future<void> _selectTime(BuildContext context) async {
    NewMedicineState? newParentState =
        context.findAncestorStateOfType<NewMedicineState>();

    MedicineInfoState? parentState =
        context.findAncestorStateOfType<MedicineInfoState>();

    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: widget.selectedTime);
    if (picked != null &&
        picked != widget.selectedTime &&
        parentState != null) {
      parentState.setState(() {
        parentState.selectedTimeList[widget.index] = picked;
      });
    }
    if (picked != null &&
        picked != widget.selectedTime &&
        newParentState != null) {
      newParentState.setState(() {
        newParentState.selectedTimeList[widget.index] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: Text(
            "${widget.selectedTime.hour}시 ${widget.selectedTime.minute}분",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
            onPressed: () {
              widget.deleteTimeHandler();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              "삭제",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
