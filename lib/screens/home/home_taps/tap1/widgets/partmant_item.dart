import 'package:flutter/material.dart';

class PartMantItem extends StatelessWidget {
  final Color backcolor;
  final String titel;
  final Color borderColor;


  PartMantItem({required this.backcolor,required this.titel,required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0,left: 4),
      child: Container(height: 50,padding: EdgeInsets.only(right: 6,left: 6),
        decoration: BoxDecoration(
            color: backcolor, border: Border.all(color: borderColor),borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(titel)),),
    );
  }
}
