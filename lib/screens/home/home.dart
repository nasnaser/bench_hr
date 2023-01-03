import 'dart:convert';


import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:bench_hr/utility/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return SafeArea(top: true,left: false,right: false,
        child: Scaffold(
          body: logic.screen,
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              onTap: logic.changeHomeTapsSelectedValue,
              // logic.chingePage,
              selectedItemColor: ColorApp.PrimaryColor,
              currentIndex: logic.navigatorValue,
              //logic.index,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,showSelectedLabels: true,

              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/image/home/home.svg",
                      height: 18,
                      width: 38,color: logic.navigatorValue==0?ColorApp.PrimaryColor:Colors.grey ,
                    ),
                    label: "الرئيسية", ),   BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        "assets/image/home/repot.svg",
                        height: 18,
                        width: 38,color: logic.navigatorValue==1?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: "التقارير"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/image/home/gitpullrequest.svg",
                      height: 18,
                      width: 38,color: logic.navigatorValue==2?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: "الطلبات"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/image/home/clock.svg",
                      height: 18,
                      width: 38,color: logic.navigatorValue==3?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: "الأجازات"),
                BottomNavigationBarItem(
                    icon:SvgPicture.asset(
                      "assets/image/home/clockstopwatch.svg",
                      height: 18,
                      width: 38,color: logic.navigatorValue==4?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: "الورديات")
              ],
            ),
          ),
        ),
      );
    });
  }
}
