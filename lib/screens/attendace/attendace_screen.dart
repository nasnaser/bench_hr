import 'package:bench_hr/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/attendace_controller.dart';

class Attendance extends GetView<AttendaceController> {
  int select = 0;
  List sort = ["الإسم الأول", "أخر تسجيل دخول", "تاريخ التعيين"];

  @override
  Widget build(BuildContext context) {
    controller.getAllEmployees();
    return GetBuilder<AttendaceController>(builder: (logic) {
      return logic.employeesModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: ColorApp.PrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 30.0, left: 30, top: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الموظفون",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
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
                                          left: 14.0,
                                          bottom: 6.0,
                                          top: 8.0,
                                          right: 8),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                child: GestureDetector(onTap: (){
                                  controller.getDepartments(context: context);
                                },
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                      "assets/image/filtericon.png",
                                      color: Colors.white),
                                )),
                              ),
                            ],
                          ))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30.0),
                  child: Row(
                    children: [
                      Text(
                        "الموظفون",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorApp.PrimaryColor),
                      ),
                      Text(
                        "(${logic.employeesModel?.data?.list?.length})",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorApp.PrimaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: logic.employeesModel?.data?.list?.length,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, bottom: 10),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, right: 10, left: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: HexColor("#D0D5DD")),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ExpansionTile(
                                title: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 25,
                                          backgroundImage: NetworkImage(logic
                                              .employeesModel!
                                              .data!
                                              .list![pos]
                                              .profilePhoto!),
                                        ),
                                        Positioned(bottom: 2,left: 0,
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                       color: Colors.red   ),
                                       ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${logic.employeesModel?.data?.list?[pos].fullName}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${logic.employeesModel?.data?.list?[pos].fullName}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),children: [
                                  SizedBox(height: 8,),
                                Divider(color: ColorApp.grayDividerColor2, height: 1, thickness: 1),
                                SizedBox(height: 8,),
                                Row(
                                  children: [SizedBox(width: 16,),
                                  CircleAvatar(maxRadius: 20,backgroundColor: HexColor("#F4F4F4"),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(backgroundColor: HexColor("#F4F4F4"),
                                      maxRadius: 15,
                                      backgroundImage: AssetImage( "assets/image/user.png",),
                                ),
                                    ),
                                  ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${logic.employeesModel?.data?.list?[pos].lineManger?.fullName}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${logic.employeesModel?.data?.list?[pos].lineManger?.jobTitle?.name}",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,color: HexColor("#98A2B3")),
                                        )
                                      ],
                                    )
                             ,
Spacer(),

                                    CircleAvatar(maxRadius: 20,backgroundColor: HexColor("#F4F4F4"),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(backgroundColor: HexColor("#F4F4F4"),
                                          maxRadius: 15,
                                          backgroundImage: AssetImage( "assets/image/logout.png",),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${logic.employeesModel?.data?.list?[pos].hiredAt}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${logic.employeesModel?.data?.list?[pos].lineManger?.jobTitle}",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,color: HexColor("#98A2B3")),
                                        )
                                      ],
                                    )

                                  ],
                                )
,
                                SizedBox(height: 8,),
                              ],
                              ),
                            ),
                          );
                        }))
              ],
            );
    });
  }
}
