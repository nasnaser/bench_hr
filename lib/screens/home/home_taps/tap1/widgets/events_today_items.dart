import 'package:bench_hr/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventsTodayItems extends StatelessWidget {
  String des;
  String title;
  String pic;
  List<String> likes;
  String back;
  String hxcolor;

  EventsTodayItems(
      {required this.des,
      required this.hxcolor,
      required this.title,
      required this.pic,
      required this.likes,
      required this.back});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          //  SvgPicture.asset("assets/image/event/backevent.svg",color: HexColor(hxcolor),fit: BoxFit.fill),
          Container(
            height: 120,
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width*.7,
            decoration: BoxDecoration(
                color: HexColor(hxcolor),//.withOpacity(.9),
                image: DecorationImage(
                    image: AssetImage(
                      "assets/image/event/back.png",
                    ),
                    opacity: .8,
                    fit: BoxFit.cover,
                     ),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [// HexColor(hxcolor)
                    SvgPicture.asset(pic,color:Colors.white,fit: BoxFit.fill,height: 20,width: 20),

                    // Text('likes ${likes.length}',
                    //     style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.white))
                  ]),SizedBox(height: 8,),
                  Text(title,maxLines: 1,overflow:TextOverflow.ellipsis ,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),Spacer(),
                  Text(des,maxLines: 1,overflow:TextOverflow.ellipsis ,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white))
                  ,Spacer()   ]),
          ),
          // Positioned(
          //     left: 20,
          //     bottom: -5,
          //     child: Container(
          //         height: 30,
          //         width: 30,
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle, color: Colors.white),
          //         child: Align(
          //           child: Image.asset(
          //             "assets/image/love.png",
          //             width: 20,
          //             height: 20,
          //           ),
          //         )))
        ],
      ),
    );
  }
}
