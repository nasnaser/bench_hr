import 'package:bench_hr/screens/home/home_taps/tap1/widgets/events_today_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  SvgPicture.asset("assets/image/calendar.svg")
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
            Stepper(  controlsBuilder: (BuildContext context, ControlsDetails dtl) {
              return Row(
                children: [
                  TextButton(onPressed: dtl.onStepContinue, child: Text("")),
                  TextButton(onPressed: dtl.onStepCancel, child: Text("")),
                ],
              );
            },
                steps: [
              Step(state: StepState.editing,label: Text(DateTime.now().toString().substring(0, 10)),subtitle: SizedBox(),

                  content: Column(
                    children: [Text("data"),Text("data"),Text("data"),],
                  ), title: Text(""))
            ])
          ]),
    );
  }
}
