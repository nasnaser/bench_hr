import 'package:bench_hr/const/app_color.dart';
import 'package:bench_hr/const/styles.dart';
import 'package:bench_hr/screen/introduction_screen/intro_controller/introduction_controller.dart';
import 'package:bench_hr/utility/conest_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IntroScreen extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GetBuilder<IntroController>(builder: (logic) {
        return Scaffold(
          backgroundColor: ColorApp.introbackgroundColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Image.asset(
                      "assets/image/arrow.png",
                      width: 20,
                      height: 10,
                    )
                ,         Row(
                      children: [
                        GestureDetector(onTap: (){logic.buttomsheetlanguage(context: context);},
                          child: SvgPicture.asset(
                            "${AppImage.imagePath}SA.svg",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ],
                    ),  ],
                ),
              ),
              Expanded(
                  child: Center(
                      child: Image.asset(
                height: size.height * .7,
                width: size.width,
                logic.introScreendata[logic.posOfIntro].img,
              ))),
              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorApp.WightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logic.introScreendata[logic.posOfIntro].title.tr,
                          style: TextStyle(
                              fontSize: 32,
                              color: ColorApp.PrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          logic.introScreendata[logic.posOfIntro].des.tr,
                          style: grayintroColornormal,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CircularPercentIndicator(progressColor:ColorApp.PrimaryColor ,
                              radius: 35,
                              percent: ((logic.posOfIntro+1)*33.333)/100 ,
                              backgroundColor:  ColorApp.WightColor,  lineWidth: 2.0,
                              center: FloatingActionButton(
                                  child: Center(
                                      child: Image.asset(
                                    "assets/image/arrowFlat.png",
                                    width: 15,
                                    height: 15,
                                  )),
                                  backgroundColor: ColorApp.PrimaryColor,
                                  onPressed: () {
                                    print("object");
                                    logic.updateposOfIntro(
                                        index: logic.posOfIntro + 1);
                                  }),
                            ),
                            Container(
                                height: 8,
                                width: 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: logic.introScreendata.length,
                                    itemBuilder: (context, pos) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 2.0, left: 2),
                                        child: Container(
                                          height: 8,
                                          width: logic.posOfIntro == pos
                                              ? 40
                                              : 18,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: logic.posOfIntro == pos
                                                  ? ColorApp.PrimaryColor
                                                  : ColorApp.greyIntroColor),
                                        ),
                                      );
                                    })),   ],
                        )
                      ]),
                ),
              ))
            ],
          ),
        );
      }),
    );
  }
}
