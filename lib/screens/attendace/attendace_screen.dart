import 'package:bench_hr/constants/app_color.dart';
import 'package:flutter/material.dart';

class Attendance extends StatelessWidget {
  int select = 0;
List sort=["الإسم الأول","أخر تسجيل دخول","تاريخ التعيين"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              color: ColorApp.PrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "الموظفون",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextField(
                            autofocus: false,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search_rounded),
                              hintText: 'بحث',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0, right: 8),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: HexColor("#80AAAA")),
                        height: 50,
                        width: 50,
                        child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset("assets/image/filtericon.png"),
                            )),
                      ),
                    ],
                  ))
            ]),
          ),
        ),
        Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "الترتيب حسب",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 60,
                  child: Center(
                    child: ListView.builder(scrollDirection: Axis.horizontal,
                        itemCount: sort.length,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(padding:  const EdgeInsets.all(8.0),
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48),
                                  color: pos == select ? HexColor("#015555"):HexColor("#E5EEEE")),
                              child: Center(child: Text(sort[pos],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: pos == select ? Colors.white:HexColor("#015555")))),    ),
                          );
                          // if(pos==select){
                          //   return
                          // }
                        }),
                  ),
                ),



Row(children: [],),


              ],
            ))
      ],
    );
  }
}
