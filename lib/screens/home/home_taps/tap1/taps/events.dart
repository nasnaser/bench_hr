import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/custom_step/mycustomstep.dart' as mycustomstep;
import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/widgets/date_event_item.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/widgets/events_today_items.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/widgets/partmant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Events extends GetView<HomeController> {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,top: 8,left: 25,right: 25),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "أحداث اليوم",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Row(
                          children: [

                            Text(
                                "${DateFormat('yy').format(controller.selectedDay )}",

                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey),maxLines: 1,
                            ),  Text(" ${DateFormat('MMMM').format(controller.selectedDay )}"),
                            Text(" ${DateFormat('dd').format(controller.selectedDay )}"),   ],
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          controller.DateTimeSheet(context: context);
                        },
                        child: SvgPicture.asset("assets/image/calendar.svg"))
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:controller
                        .getdayEvent(
                        DateTime.now()  )
                        ?.length,
                    itemBuilder: (context, pos) {
                      return EventsTodayItems(
                        title: controller
                            .getdayEvent(
                            DateTime.now()  )
                            ?[pos].name??"",
                        des:  controller
                            .getdayEvent(
                            DateTime.now()  )
                        ?[pos].description??"",
                        back: "assets/image/event/event1.png",
                        likes: [],
                        pic: "assets/image/event/Icon.png",
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,top: 8,left: 25,right: 25),
                child: Text(
                  "الأقسـام",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              GetBuilder<HomeController>(builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,top: 8,right: 25),
                  child: SizedBox(
                      height: 30,
                      child: logic.eventTypesModel == null
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  logic.eventTypesModel?.data?.list?.length,
                              itemBuilder: (context, pos) {
                                return GestureDetector(onTap: (){
                                  logic.updateevent_typeandisFilter(type: logic.eventTypesModel!
                                      .data!.list![pos].id!, filter: true);
                                },
                                  child: PartMantItem(
                                    backcolor: HexColor(logic.eventTypesModel!
                                            .data!.list![pos].color!)
                                        .withOpacity(.1),
                                    borderColor: HexColor(logic.eventTypesModel!
                                        .data!.list![pos].color!),
                                    titel: logic
                                        .eventTypesModel!.data!.list![pos].name!,
                                  ),
                                );
                              })),
                );
              }),
              Divider(
                  color: ColorApp.grayDividerColor2, height: 1, thickness: 1),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,top: 8,left: 25,right: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(.3),
                        ),
                        width: 50,
                        height: 50,
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              "${DateFormat('dd').format(controller.selectedDay )}",
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${DateFormat('MMMM').format(controller.selectedDay ?? DateTime.now())}\n${DateFormat('yy').format(controller.selectedDay ?? DateTime.now())}",
                              maxLines: 3,
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: GetBuilder<HomeController>(builder: (logic) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: logic
                                .getdayEvent(
                                    logic.selectedDay  )
                                ?.length,
                            itemBuilder: (context, pos) {
                              String des = "";
                              List list = logic
                                      .getdayEvent(logic.selectedDay ??
                                          DateTime.now())?[pos]
                                      ?.description
                                      ?.split(" ") ??
                                  [];
                              // if(list.length>5){
                              //   for(int i=0;i<5;){
                              //     des=des+list[i];
                              //   }
                              //   }else{
                              des = logic
                                      .getdayEvent(logic.selectedDay ??
                                          DateTime.now())?[pos]
                                      ?.description ??
                                  "";
                              //   }

                              if (logic.isFilter) {
                                if (logic
                                        .getdayEvent(logic.selectedDay)[pos]
                                        .eventType!
                                        .id ==
                                    logic.event_type) {
                                  return DateEventItem(
                                    event: des,
                                    image:
                                        "https://tse4.mm.bing.net/th?id=OIP.HdETgqkYpSTZhRHQcDetIgHaFS&pid=Api&P=0",
                                    name: logic
                                            .getdayEvent(logic.selectedDay ??
                                                DateTime.now())[pos]
                                            .name ??
                                        "",
                                  );
                                } else {
                                  return SizedBox();
                                }
                              } else {
                                return DateEventItem(
                                  event: des,
                                  image:
                                      "https://tse4.mm.bing.net/th?id=OIP.HdETgqkYpSTZhRHQcDetIgHaFS&pid=Api&P=0",
                                  name: logic
                                          .getdayEvent(logic.selectedDay ??
                                              DateTime.now())[pos]
                                          .name ??
                                      "",
                                );
                              }
                            });
                      }),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
