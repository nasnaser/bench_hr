import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/custom_step/mycustomstep.dart' as mycustomstep;
import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/widgets/date_event_item.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/widgets/events_today_items.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/widgets/partmant_item.dart';
import 'package:bench_hr/utility/conest_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Events extends GetView<HomeController> {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.eventCotext=context;
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, top: 8, left: 25, right: 25),
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
                            " ${DateFormat.d('ar_SA').format(controller.selectedDay)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          Text(
                            " ${DateFormat.MMMM('ar_SA').format(controller.selectedDay)}",
                            // " ${DateFormat('MMMM').format(controller.selectedDay)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          Text(
                            "${DateFormat.y('ar_SA').format(controller.selectedDay)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black54),
                            maxLines: 1,
                          ),
                        ],
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
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 0),
              child: SizedBox(
                height: 130,
                child: GetBuilder<HomeController>(builder: (logic) {
                  return logic.eventsDay == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : logic.eventsDay!.data!.list!.length == 0
                          ? Center(
                              child: Text(
                                "لا توجد أية أحداث في هذا اليوم",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: logic.eventsDay?.data?.list?.length,
                              itemBuilder: (context, pos) {
                                return EventsTodayItems(
                                  title:
                                      logic.eventsDay?.data?.list?[pos].name ??
                                          "",
                                  des: logic.eventsDay?.data?.list?[pos]
                                          .description ??
                                      "",
                                  back: "assets/image/event/event1.png",
                                  hxcolor: logic.eventsDay!.data!.list![pos]
                                      .eventType!.color!,
                                  likes: [],
                                  pic: AppImage.getimageEventsIconPath(
                                      eventIcon:
                                          "${logic.eventsDay!.data!.list![pos].eventType!.icon!}"),
                                );
                              });
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, top: 8, left: 25, right: 25),
              child: Text(
                "الأقسـام",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            GetBuilder<HomeController>(builder: (logic) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8, right: 25),
                child: SizedBox(
                    height: 30,
                    child: logic.eventTypesModel == null
                        ? CircularProgressIndicator()
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  logic.updateevent_typeandisFilter(
                                      type: 10000, filter: false);
                                },
                                child: PartMantItem(
                                  textColor: logic.isFilter
                                      ? Colors.black54
                                      : Colors.white,
                                  backcolor: logic.isFilter
                                      ? HexColor("#015555").withOpacity(.1)
                                      : HexColor("#015555"),
                                  borderColor: logic.isFilter
                                      ? HexColor("#015555")
                                      : Colors.white,
                                  titel: "الكل",
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: logic
                                        .eventTypesModel?.data?.list?.length,
                                    itemBuilder: (context, pos) {
                                      return GestureDetector(
                                        onTap: () {
                                          logic.updateevent_typeandisFilter(
                                              type: logic.eventTypesModel!.data!
                                                  .list![pos].id!,
                                              filter: true);
                                        },
                                        child: PartMantItem(
                                          textColor: logic.event_type ==
                                                      logic
                                                          .eventTypesModel!
                                                          .data!
                                                          .list![pos]
                                                          .id &&
                                                  logic.isFilter
                                              ? Colors.white
                                              : Colors.black54,
                                          backcolor: logic.event_type ==
                                                      logic
                                                          .eventTypesModel!
                                                          .data!
                                                          .list![pos]
                                                          .id &&
                                                  logic.isFilter
                                              ? HexColor(logic.eventTypesModel!
                                                  .data!.list![pos].color!)
                                              : HexColor(logic.eventTypesModel!
                                                      .data!.list![pos].color!)
                                                  .withOpacity(.1),
                                          borderColor: logic.event_type ==
                                                      logic
                                                          .eventTypesModel!
                                                          .data!
                                                          .list![pos]
                                                          .id &&
                                                  logic.isFilter
                                              ? Colors.white
                                              : HexColor(logic.eventTypesModel!
                                                  .data!.list![pos].color!),
                                          titel: logic.eventTypesModel!.data!
                                              .list![pos].name!,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )),
              );
            }),
            Divider(color: ColorApp.grayDividerColor2, height: 1, thickness: 1),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, top: 8, left: 25, right: 25),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.daysDateList.length,
                      itemBuilder: (context, pos) {
                        if (controller.isFilter) {
                          return Visibility(
                              visible: controller.checkIfListHaveItemInFilter(
                                  filterId: controller.event_type,
                                  list: controller.selectedEvents[
                                      controller.daysDateList[pos]]!),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor("#F2F6F6"),
                                      ),
                                      width: 48,
                                      height: 48,
                                      child: Center(
                                          child: Column(
                                        children: [
                                          Text(
                                            "${DateFormat.d('ar_SA').format(DateTime.parse(controller.daysDateList[pos]))}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${DateFormat.MMMM('ar_SA').format(DateTime.parse(controller.daysDateList[pos]))}\n${DateFormat.y('ar_SA').format(DateTime.parse(controller.daysDateList[pos]))}",
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
                                    child: GetBuilder<HomeController>(
                                        builder: (logic) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: logic
                                              .selectedEvents[
                                                  controller.daysDateList[pos]]
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            String des = "";
// List list = logic
//     .getdayEvent(logic.selectedDay ??
// DateTime.now())?[pos]
//     ?.description
//     ?.split(" ") ??
// [];
// // if(list.length>5){
// //   for(int i=0;i<5;){
// //     des=des+list[i];
// //   }
// //   }else{
// des = logic
//     .getdayEvent(logic.selectedDay ??
// DateTime.now())?[pos]
//     ?.description ??
// "";
// //   }

                                            if (logic.isFilter) {
                                              if (logic
                                                      .selectedEvents[controller
                                                              .daysDateList[
                                                          pos]]![index]
                                                      .eventType!
                                                      .id ==
                                                  logic.event_type) {
                                                return DateEventItem(
                                                  imageColor: logic
                                                      .selectedEvents[controller
                                                              .daysDateList[
                                                          pos]]![index]
                                                      .eventType!
                                                      .color!,
                                                  event: logic
                                                      .selectedEvents[controller
                                                              .daysDateList[
                                                          pos]]![index]
                                                      .description!,
                                                  image: AppImage
                                                      .getimageEventsIconPath(
                                                          eventIcon: logic
                                                                  .selectedEvents[
                                                                      controller
                                                                              .daysDateList[
                                                                          pos]]![
                                                                      index]
                                                                  .eventType!
                                                                  .icon! ) ,
                                                  name: logic
                                                          .selectedEvents[controller
                                                                  .daysDateList[
                                                              pos]]![index]
                                                          .name ??
                                                      "",
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            } else {
                                              return DateEventItem(
                                                imageColor: logic
                                                    .selectedEvents[
                                                        controller.daysDateList[
                                                            pos]]![index]
                                                    .eventType!
                                                    .color!,
                                                event: logic
                                                        .selectedEvents[controller
                                                                .daysDateList[
                                                            pos]]![index]
                                                        .description ??
                                                    "",
                                                image: AppImage
                                                    .getimageEventsIconPath(
                                                        eventIcon: logic
                                                                .selectedEvents[
                                                                    controller
                                                                            .daysDateList[
                                                                        pos]]![
                                                                    index]
                                                                .eventType!
                                                                .icon! )  ,
                                                name: logic
                                                        .selectedEvents[controller
                                                                .daysDateList[
                                                            pos]]![index]
                                                        .name ??
                                                    "",
                                              );
                                            }
                                          });
                                    }),
                                  ),
                                ],
                              ));
                        } else {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: HexColor("#F2F6F6"),
                                  ),
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Text(
                                        "${DateFormat.d('ar_SA').format(DateTime.parse(controller.daysDateList[pos]))}",
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${DateFormat.MMMM('ar_SA').format(DateTime.parse(controller.daysDateList[pos]))}\n${DateFormat.y('ar_SA').format(DateTime.parse(controller.daysDateList[pos]))}",
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
                                child: GetBuilder<HomeController>(
                                    builder: (logic) {


                               return       Column(children:logic
                                          !.selectedEvents[
                                      controller!.daysDateList[
                                      pos]]!.map((e) {
                                        if (logic.isFilter) {
                                          if (e
                                              .eventType!
                                              .id ==
                                              logic.event_type) {
                                            return DateEventItem(
                                              event: e
                                                  .description!,
                                              image: AppImage
                                                  .getimageEventsIconPath(
                                                  eventIcon:e
                                                      .eventType!
                                                      .icon!  )  ,
                                              name: e
                                                  .name ??
                                                  "",
                                              imageColor: e
                                                  .eventType!
                                                  .color!,
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        }
                                        else {
                                          // print(
                                          //     " logic.selectedEvents[controller.daysDateList[pos]]![index].eventType!.icon!   =>${ e.eventType!.icon!}");
                                          //
                                          //
                                          // print(
                                          //     " logic.selectedEvents[controller.daysDateList[pos]]![index].eventType!.icon!   =>${ AppImage.getimageEventsIconPath(
                                          //         eventIcon: e
                                          //             .eventType!
                                          //             .icon! )}");

                                          return DateEventItem(
                                            imageColor: e
                                                .eventType!
                                                .color!,
                                            event: e
                                                .description ??
                                                "",
                                            image: AppImage.getimageEventsIconPath(
                                                eventIcon: e
                                                    .eventType!
                                                    .icon!) ,
                                            name: e
                                                .name ??
                                                "",
                                          );
                                        };
                                      }).toList(),);



//                                   return ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: logic
//                                           .selectedEvents[
//                                               controller.daysDateList[pos]]
//                                           ?.length,
//                                       itemBuilder: (context, index) {
//                                         String des = "";
// // List list = logic
// //     .getdayEvent(logic.selectedDay ??
// // DateTime.now())?[pos]
// //     ?.description
// //     ?.split(" ") ??
// // [];
// // // if(list.length>5){
// // //   for(int i=0;i<5;){
// // //     des=des+list[i];
// // //   }
// // //   }else{
// // des = logic
// //     .getdayEvent(logic.selectedDay ??
// // DateTime.now())?[pos]
// //     ?.description ??
// // "";
// // //   }
//
//                                         if (logic.isFilter) {
//                                           if (logic
//                                                   .selectedEvents[
//                                                       controller.daysDateList[
//                                                           pos]]![index]
//                                                   .eventType!
//                                                   .id ==
//                                               logic.event_type) {
//                                             return DateEventItem(
//                                               event: logic
//                                                   .selectedEvents[
//                                                       controller.daysDateList[
//                                                           pos]]![index]
//                                                   .description!,
//                                               image: AppImage
//                                                   .getimageEventsIconPath(
//                                                       eventIcon: logic
//                                                               .selectedEvents[
//                                                                   controller
//                                                                           .daysDateList[
//                                                                       pos]]![
//                                                                   index]
//                                                               .eventType!
//                                                               .icon!  )  ,
//                                               name: logic
//                                                       .selectedEvents[controller
//                                                               .daysDateList[
//                                                           pos]]![index]
//                                                       .name ??
//                                                   "",
//                                               imageColor: logic
//                                                   .selectedEvents[
//                                                       controller.daysDateList[
//                                                           pos]]![index]
//                                                   .eventType!
//                                                   .color!,
//                                             );
//                                           } else {
//                                             return SizedBox();
//                                           }
//                                         }
//                                         else {
//                                           print(
//                                               " logic.selectedEvents[controller.daysDateList[pos]]![index].eventType!.icon!   =>${ logic
//                                                   .selectedEvents[
//                                               controller.daysDateList[
//                                               pos]]![index].eventType!.icon!}");
//
//
//                                           print(
//                                               " logic.selectedEvents[controller.daysDateList[pos]]![index].eventType!.icon!   =>${ AppImage.getimageEventsIconPath(
//                                                   eventIcon: logic
//                                                       .selectedEvents[controller
//                                                       .daysDateList[
//                                                   pos]]![index]
//                                                       .eventType!
//                                                       .icon! )}");
//
//                                           return DateEventItem(
//                                             imageColor: logic
//                                                 .selectedEvents[controller
//                                                     .daysDateList[pos]]![index]
//                                                 .eventType!
//                                                 .color!,
//                                             event: logic
//                                                     .selectedEvents[
//                                                         controller.daysDateList[
//                                                             pos]]![index]
//                                                     .description ??
//                                                 "",
//                                             image: AppImage.getimageEventsIconPath(
//                                                 eventIcon: logic
//                                                         .selectedEvents[controller
//                                                                 .daysDateList[
//                                                             pos]]![index]
//                                                         .eventType!
//                                                         .icon!) ,
//                                             name: logic
//                                                     .selectedEvents[
//                                                         controller.daysDateList[
//                                                             pos]]![index]
//                                                     .name ??
//                                                 "",
//                                           );
//                                         }
//                                       });
                                }),
                              ),
                            ],
                          );
                        }
                      })),
            )
          ]),
    );
  }
}

//
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Expanded(
// flex: 1,
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Colors.grey.withOpacity(.3),
// ),
// width: 50,
// height: 50,
// child: Center(
// child: Column(
// children: [
// Text(
// "${DateFormat('dd').format(
// controller.selectedDay)}",
// maxLines: 3,
// style: TextStyle(
// fontSize: 10,
// fontWeight: FontWeight.bold),
// textAlign: TextAlign.center,
// ),
// Text(
// "${DateFormat('MMMM').format(
// controller.selectedDay ??
// DateTime.now())}\n${DateFormat('yy')
// .format(controller.selectedDay ??
// DateTime.now())}",
// maxLines: 3,
// style: TextStyle(fontSize: 10),
// textAlign: TextAlign.center,
// ),
// ],
// )),
// ),
// ),
// Expanded(
// flex: 5,
// child: GetBuilder<HomeController>(builder: (logic) {
// return ListView.builder(
// shrinkWrap: true,
// itemCount: logic
//     .getdayEvent(
// logic.selectedDay)
//     ?.length,
// itemBuilder: (context, pos) {
// String des = "";
// List list = logic
//     .getdayEvent(logic.selectedDay ??
// DateTime.now())?[pos]
//     ?.description
//     ?.split(" ") ??
// [];
// // if(list.length>5){
// //   for(int i=0;i<5;){
// //     des=des+list[i];
// //   }
// //   }else{
// des = logic
//     .getdayEvent(logic.selectedDay ??
// DateTime.now())?[pos]
//     ?.description ??
// "";
// //   }
//
// if (logic.isFilter) {
// if (logic
//     .getdayEvent(logic.selectedDay)[pos]
//     .eventType!
//     .id ==
// logic.event_type) {
// return DateEventItem(
// event: des,
// image:
// "https://tse4.mm.bing.net/th?id=OIP.HdETgqkYpSTZhRHQcDetIgHaFS&pid=Api&P=0",
// name: logic
//     .getdayEvent(logic.selectedDay ??
// DateTime.now())[pos]
//     .name ??
// "",
// );
// } else {
// return SizedBox();
// }
// } else {
// return DateEventItem(
// event: des,
// image:
// "https://tse4.mm.bing.net/th?id=OIP.HdETgqkYpSTZhRHQcDetIgHaFS&pid=Api&P=0",
// name: logic
//     .getdayEvent(logic.selectedDay ??
// DateTime.now())[pos]
//     .name ??
// "",
// );
// }
// });
// }),
// ),
// ],
// ),
