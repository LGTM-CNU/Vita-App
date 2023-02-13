import 'package:flutter/material.dart';
import 'package:vita/Screen/MedicineInfo.dart';

class MedicineCard extends StatefulWidget {
  const MedicineCard(
      {Key? key,
      required this.medicineID,
      required this.title,
      required this.color,
      required this.thumbnail,
      required this.type})
      : super(key: key);
  final int medicineID;
  final String title;
  final int color;
  final String thumbnail;
  final String type;

  @override
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // fetch 이후 args 로 넘겨주기
        Navigator.pushNamed(context, "/medicine_info",
            arguments: MedicineInfoArgs(widget.medicineID));
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
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Color(widget.color),
            ),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(widget.thumbnail),
                        ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        widget.type,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
