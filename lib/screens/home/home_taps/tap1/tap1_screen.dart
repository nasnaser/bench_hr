import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/constants/styles.dart';
import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/taps/events.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/taps/tap1_tap1.dart';
import 'package:bench_hr/screens/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tap1Screen extends GetView<HomeController> {
  const Tap1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(children: [
              Icon(Icons.notifications_none_outlined,
                  color: ColorApp.iconColor),
              SizedBox(
                width: 4,
              ),
              Icon(Icons.search_rounded, color: ColorApp.iconColor),
              Spacer(),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    logic.logInVerifyModel!.data!.user!.profilePhoto!),
              ),
              Spacer(),
              Image.asset("assets/image/logo/Long.png",
                  width: 40, height: 25, fit: BoxFit.fill),
            ]),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                    padding: EdgeInsets.all(0),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 5,
                    indicatorColor: ColorApp.PrimaryColor,
                    controller: controller.tabController,
                    tabs: [
                      Tab(
                        child: Text("    الحضور    ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                      ),
                      Tab(
                        child: Text("    الاخبار    ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                      ),
                      Tab(
                        child: Text("    الأحداث    ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                      ),
                    ]),
              ),
              Divider(
                  height: 1, color: ColorApp.grayDividerColor, thickness: 1),
              Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.amberAccent,
                    ),
                    Tap1Tap1(),
                    Events(),
                  ])),


            ],
          ));
    });
  }
}
