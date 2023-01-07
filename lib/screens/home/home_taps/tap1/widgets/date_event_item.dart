import 'package:bench_hr/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateEventItem extends StatelessWidget {
  String name;
  String event;
  String image;
String imageColor;
  DateEventItem({required this.name, required this.event, required this.image,required this.imageColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 8,bottom: 8),
      child: Container(height: 60,//width: MediaQuery.of(context).size.width*.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: HexColor("#F2F6F6")),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center , children: [      SizedBox(width: 10,),
          SvgPicture.asset(image,color:HexColor(imageColor),fit: BoxFit.fill,height: 20,width: 20),
           SizedBox(width: 10,), Expanded(
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,maxLines: 1,overflow:TextOverflow.ellipsis ,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: HexColor("#344054")),
                  )
                , Text(
                    event,maxLines: 1,overflow:TextOverflow.ellipsis ,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12,color: HexColor("#98A2B3")),
                  ),],
              ),
           ),
       ]),
        ),
      ),
    );
  }
}
