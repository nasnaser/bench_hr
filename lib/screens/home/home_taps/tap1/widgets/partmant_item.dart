import 'package:flutter/material.dart';

class PartMantItem extends StatelessWidget {
  final Color backcolor;
  final String titel;
  final Color borderColor;
  final Color textColor;

  PartMantItem(
      {required this.backcolor,
      required this.titel,
      required this.borderColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        padding: EdgeInsets.only(right: 15, left: 15),
        decoration: BoxDecoration(
            color: backcolor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          titel,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
