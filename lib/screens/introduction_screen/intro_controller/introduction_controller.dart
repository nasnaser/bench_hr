
import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/utility/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  List<IntroData> introScreendata = [
    IntroData(
        title: "hello",
        des:
            "name",
        img: "assets/image/intro/3.png"),
    IntroData(
        title: "تتبع العمل بدقة",
        des:
            "وتختصر الأداة الخطوة المعتادة المتمثالكلام إلى نص ومن ثم تحويلها إلى كلام مرة أخرى المتمثلة في ترجمة ",
        img: "assets/image/intro/4.png"),
    IntroData(
        title: "تتبع العمل بدقة",
        des:
            "وتختصر الأداة الخطوة المعتادة المتمثالكلام إلى نص ومن ثم تحويلها إلى كلام مرة أخرى المتمثلة في ترجمة ",
        img: "assets/image/intro/15.png"),
  ];

  int posOfIntro = 0;
  bool language = true;
  String lang = "en";

  @override
  void onInit() {
    super.onInit();
    lang=SecureStorage.readSecureData("lang")??"ar";
  }

  updatelanguage({required bool lang}) {
    language = lang;
    update();
  }

  updateposOfIntro({required int index}) {
    if (index >= introScreendata.length) {
      SecureStorage.writeIntro("1");
      Get.toNamed("/login");
    } else {
      posOfIntro = index;

      update();
    }
  }

  updateLang(String lang) {
    final locale = Locale(lang);

    SecureStorage.writeSecureData(SecureStorage.lang, lang);
    Get.updateLocale(locale);
  }

  Future buttomsheetlanguage({
    required BuildContext context,
  }) async {
    Get.bottomSheet(GetBuilder<IntroController>(builder: (logic) {
      // assets/image/flags/AD.svg
      return Container(height: MediaQuery.of(context).size.height*.33,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            children: [     Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8),
              child: Row(
                children: [
                  Text("لغه التطبيق",style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8,top: 8),
                child: Row(
                  children: [
                    Text("ما هي لغتك المفضلة؟",style: TextStyle(color: ColorApp.greyIntroColor2,fontSize: 18)),

                  ],
                ),
              ),

              Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/image/flags/SA.svg",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text("عربي",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Spacer(),
                  Radio(activeColor: ColorApp.PrimaryColor,
                      value: "ar",
                      groupValue: lang,
                      onChanged: (v) {
                        lang = v!;
                        updateLang("ar");
                      }),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/image/flags/GB.svg",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text("English",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Spacer(),
                  Radio(activeColor: ColorApp.PrimaryColor,
                      value: "en",
                      groupValue: lang,
                      onChanged: (v) {
                        lang = v!;
                        updateLang("en");
                      }),
                ],
              ),
              Spacer(),
            ],
          ));
    }));
  }
}

class IntroData {
  final String img;
  final String title;
  final String des;

  IntroData({required this.img, required this.title, required this.des});
}
