import 'package:flutter/material.dart';

import 'package:vita/Screen/NewMedicine.dart';

class TimePicker extends StatefulWidget {
  final selectedTime;
  final index;

  const TimePicker(
      {super.key, required this.selectedTime, required this.index});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  Future<void> _selectTime(BuildContext context) async {
    NewMedicineState? parentState =
        context.findAncestorStateOfType<NewMedicineState>();

    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: widget.selectedTime);
    if (picked != null &&
        picked != widget.selectedTime &&
        parentState != null) {
      parentState.setState(() {
        parentState.selectedTimeList[widget.index] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    NewMedicineState? parentState =
        context.findAncestorStateOfType<NewMedicineState>();
    return Row(
      children: [
        const Spacer(),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: Text(
            "${widget.selectedTime.hour}:${widget.selectedTime.minute}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
            onPressed: () {
              if (parentState!.selectedTimeList == null) return;
              parentState.setState(() {
                parentState.selectedTimeList.removeAt(widget.index);
              });
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
