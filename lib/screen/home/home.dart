import 'dart:convert';

import 'package:bench_hr/const/app_color.dart';
import 'package:bench_hr/network/json_model/logIn_verify_model.dart';
import 'package:bench_hr/screen/home/controllers/home_controller.dart';
import 'package:bench_hr/screen/shared_widget/custom_button.dart';
import 'package:bench_hr/utility/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return SafeArea(
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
              showUnselectedLabels: false,showSelectedLabels: false,

              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/image/home/home.png",
                      height: 30,
                      width: 30,color: logic.navigatorValue==0?ColorApp.PrimaryColor:Colors.grey ,
                    ),
                    label: "", ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/image/home/req.png",
                      height: 30,
                      width: 30,color: logic.navigatorValue==1?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/image/home/history.png",
                      height: 30,
                      width: 30,color: logic.navigatorValue==2?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/image/home/time.png",
                      height: 30,
                      width: 30,color: logic.navigatorValue==3?ColorApp.PrimaryColor:Colors.grey
                    ),
                    label: "")
              ],
            ),
          ),
        ),
      );
    });
  }
}
