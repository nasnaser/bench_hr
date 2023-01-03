import 'package:bench_hr/constants/app_color.dart';
import 'package:flutter/material.dart';

class DateEventItem extends StatelessWidget {
  String name;
  String event;
  String image;

  DateEventItem({required this.name, required this.event, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 70,//width: MediaQuery.of(context).size.width*.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: HexColor("#F2F6F6")),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.network(
              image,
              width: 100,
              height: 100,
            ),
           SizedBox(width: 10,), Column(
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: HexColor("#344054")),
                )
              , Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12,color: HexColor("#98A2B3")),
                ),],
            ),
          Icon(Icons.more_horiz) ]),
        ),
      ),
    );
  }
}
