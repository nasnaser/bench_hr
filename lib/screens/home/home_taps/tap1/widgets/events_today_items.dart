import 'package:flutter/material.dart';

class EventsTodayItems extends StatelessWidget {
  String des;
  String title;
  String pic;
  List<String> likes;
  String back;

  EventsTodayItems(
      {required this.des,
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
          Container(
            height: 140,padding: EdgeInsets.all(16),
            width: 200,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(back)),
                borderRadius: BorderRadius.circular(15)),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
              Row(children: [
                Image.asset(
                  pic,
                  width: 30,
                  height: 30,
                ),
                Spacer(),
                Text('likes ${likes.length}',  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white))
              ]),
              Text(title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white)),
              Text(des,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.white))
            ]),
          ),
          Positioned(
              left: 20,
              bottom: -5,
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Align(
                    child: Image.asset(
                      "assets/image/love.png",
                      width: 20,
                      height: 20,
                    ),
                  )))
        ],
      ),
    );
  }
}
