import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final selectedTime;

  const TimePicker({super.key, required this.selectedTime});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: widget.selectedTime);
    if (picked != null && picked != widget.selectedTime) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.black,
          )),
          child: Text(
            "${widget.selectedTime.hour}:${widget.selectedTime.minute}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: const Text(
            "알림 시간 선택",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            "알림 시간 삭제",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
