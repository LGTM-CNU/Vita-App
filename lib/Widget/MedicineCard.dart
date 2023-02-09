import 'package:flutter/material.dart';

class MedicineCard extends StatefulWidget {
  const MedicineCard(
      {Key? key,
      required this.title,
      required this.color,
      required this.thumbnail,
      required this.type})
      : super(key: key);
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
    return (Padding(
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
                        repeat: ImageRepeat.repeat,
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
    ));
  }
}
