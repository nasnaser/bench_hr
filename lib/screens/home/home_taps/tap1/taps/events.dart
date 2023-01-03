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
                padding: const EdgeInsets.all(8.0),
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
                        Text(
                          DateTime.now().toString().substring(0, 10),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey),
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
                    itemCount: 3,
                    itemBuilder: (context, pos) {
                      return EventsTodayItems(
                        title: "إنضمام عبد الله محمد ",
                        des: "إنضمام عبد الله محمد ",
                        back: "assets/image/event/event1.png",
                        likes: [],
                        pic: "assets/image/event/Icon.png",
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "الأقسـام",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              GetBuilder<HomeController>(builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8, top: 0, bottom: 4),
                  child: SizedBox(
                      height: 30,
                      child:logic.eventTypesModel==null?CircularProgressIndicator(): ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.eventTypesModel?.data?.list?.length,
                          itemBuilder: (context, pos) {
                            return PartMantItem(
                              backcolor: HexColor(logic
                                      .eventTypesModel!.data!.list![pos].color!)
                                  .withOpacity(.1),
                              borderColor: HexColor(logic
                                  .eventTypesModel!.data!.list![pos].color!),
                              titel:
                                  logic.eventTypesModel!.data!.list![pos].name!,
                            );
                          })),
                  // child: SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       PartMantItem(
                  //         backcolor: HexColor("#015555").withOpacity(.1),
                  //         borderColor: HexColor("#015555"),
                  //         titel: "الكل",
                  //       ),
                  //       PartMantItem(
                  //         backcolor: HexColor("#4285F4").withOpacity(.1),
                  //         borderColor: HexColor("#4285F4"),
                  //         titel: "الذكرى السنوية",
                  //       ),
                  //       PartMantItem(
                  //         backcolor: HexColor("#4285F4").withOpacity(.1),
                  //         borderColor: HexColor("#4285F4"),
                  //         titel: "حفلة وداع",
                  //       ),
                  //       PartMantItem(
                  //         backcolor: HexColor("#FECDCA").withOpacity(.1),
                  //         borderColor: HexColor("#FECDCA"),
                  //         titel: "عيد ميلاد",
                  //       ),
                  //       PartMantItem(
                  //         backcolor: HexColor("#FDB022").withOpacity(.1),
                  //         borderColor: HexColor("#FDB022"),
                  //         titel: "موظف جديد",
                  //       ),
                  //       PartMantItem(
                  //         backcolor: HexColor("#209000").withOpacity(.1),
                  //         borderColor: HexColor("#209000"),
                  //         titel: "الموظف المثالي",
                  //       ),
                  //     ],
                  //   ),
                  // ),
                );
              }),
              Divider(
                  color: ColorApp.grayDividerColor2, height: 1, thickness: 1),
              Column(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          width: 60,
                          height: 60,
                          child: Center(
                              child: Text(
                                  DateTime.now().toString().substring(0, 10))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: List.generate(index * 2, (indexx) {
                            return DateEventItem(
                              event: "الذكرى السنوية (5 سنوات)",
                              image:
                                  "https://tse4.mm.bing.net/th?id=OIP.HdETgqkYpSTZhRHQcDetIgHaFS&pid=Api&P=0",
                              name: "عبد الله محمد ",
                            );
                          }),
                        )
                      ],
                    ),
                  );
                }),
              )
            ]),
      ),
    );
  }
}
