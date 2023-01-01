
import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/constants/styles.dart';
import 'package:bench_hr/screens/home/controllers/home_controller.dart';
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
              Icon(Icons.notifications_none_outlined),
              SizedBox(
                width: 4,
              ),
              Icon(Icons.search_rounded),
              Spacer(),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    logic.logInVerifyModel!.data!.user!.profilePhoto!),
              ),
              Spacer(),
              Image.asset("assets/image/logo/Long.png",
                  width: 50, height: 30, fit: BoxFit.fill),
            ]),
          ),
          body: NestedScrollView(
              // Setting floatHeaderSlivers to true is required in order to float
              // the outer slivers over the inner scrollable.
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    floating: true,
                    expandedHeight: 400.0,
                    //collapsedHeight: 100,
                    forceElevated: innerBoxIsScrolled,
                    collapsedHeight: 400,
                    flexibleSpace: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorApp.PrimaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${controller.logInVerifyModel?.data?.user?.fullName}",
                                        style: whiteTextColor,
                                      ),
                                      Text(
                                        "${controller.logInVerifyModel?.data?.user?.timezone}",
                                        style: whiteTextColor,
                                      )
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                          "assets/image/emoji.png",
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "تم تسجيل حضورك",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorApp.SuccessColor),
                                ),
                                Text(
                                  "تسجيل حضور في 7 ساعات و 50 دقيقة",
                                  style: whiteTextColor,
                                ),
                                Spacer(),
                                CustomButton(
                                  width: MediaQuery.of(context).size.width * .8,
                                  height: 50,
                                  title: "تسجيل إنصراف",
                                  onClick: () {},
                                  buttonColor: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  borderRadius: 15,
                                  titleColor: ColorApp.PrimaryColor,
                                ),
                                Spacer()
                              ]),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                ];
              },
              body: Column(
                children: [
                  TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 5,
                      indicatorColor: ColorApp.PrimaryColor,
                      controller: controller.tabController,
                      tabs: [
                        Tab(
                          child: Text("الاخبار",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ),
                        Tab(
                          child: Text("الاخبار",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ),
                        Tab(
                          child: Text("الاخبار",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(
                          controller: controller.tabController,
                          children: [Tap1Tap1(), Tap1Tap1(), Tap1Tap1()]))
                ],
              )));
    });
  }
}
