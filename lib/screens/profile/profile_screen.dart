import 'package:bench_hr/constants/app_color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.PrimaryColor,
        body: Stack(alignment: Alignment.topCenter,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor("#347777"),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/image/profile/call.png",
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor("#347777"),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/image/profile/mail.png",
                    ),
                  ),
                )    ],
            ),


            Positioned(
                top: MediaQuery.of(context).size.height*.2,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                )),
            Positioned(//top: MediaQuery.of(context).size.height*.2,
              child: Container(height: MediaQuery.of(context).size.height*.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36))),

                width: MediaQuery.of(context).size.width,

              ),
            ),   ],
        ));
  }
}

//
//
//
//
// Column(children: [
// Padding(
// padding: const EdgeInsets.only(top: 20, right: 20.0, left: 20),
// child: Stack(
// children: [
// Row(
// children: [
// Container(
// height: 40,
// width: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: HexColor("#347777"),
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Image.asset(
// "assets/image/profile/call.png",
// ),
// ),
// ),
// SizedBox(
// width: 8,
// ),
// Container(
// height: 40,
// width: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: HexColor("#347777"),
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Image.asset(
// "assets/image/profile/mail.png",
// ),
// ),
// )    ],
// ),
//
// ],
// ),
// ),
// SizedBox(
// height: 20,
// ),
// Expanded(
// child: Stack(
// children: [
//
// Container(
// decoration: BoxDecoration( color: Colors.white,
// borderRadius: BorderRadius.only(topLeft: Radius.circular(36),topRight: Radius.circular(36))),
//
// width: MediaQuery.of(context).size.width,
// //  height: MediaQuery.of(context).size.height * .8,
// ),
// Positioned(top: -25,child: Container(width: 50,height: 50,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)) ],
// ),
// )
// ]),
