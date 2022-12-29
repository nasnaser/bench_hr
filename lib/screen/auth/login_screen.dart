import 'package:bench_hr/const/styles.dart';
import 'package:bench_hr/screen/auth/controllers/login_controller.dart';
import 'package:bench_hr/screen/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../const/app_color.dart';

import '../../network/json_model/emoji_json_model.dart';
import '../../utility/conest_image.dart';

class LogInScreen extends GetView<LogInController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorApp.PrimaryColor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8, top: 8),
            child: Row(
              children: [
                Text(
                  "تسجيل الدخول",
                  style: normalWightColorTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "أدخل رقم جوالك لبدء استخدام بينش.",
              style: normalWightColorTextStylelLOgin,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GetBuilder<LogInController>(builder: (logic) {
            return Expanded(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: ColorApp.WightColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        "سنقوم بإرسال رمز التحقيق إلى رقم جوالك",
                        style: normalPrimaryColorTextStyle,
                      ),SizedBox(height: 16,),
                      GetBuilder<LogInController>(builder: (logic) {
                        return GestureDetector(
                          onTap: () {
                            controller.buttomsheetCanteryList(context: context);
                            // controller.  shhhh(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: ColorApp.PrimaryColor,
                                )),
                            child: Row(children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgPicture.asset(
                                        "${AppImage.imagePath}${logic.conutrieFlag}.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        controller.conutrieCode,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                                  decoration: BoxDecoration(
                                    color: ColorApp.PrimaryColor,
                                    borderRadius: Get.locale!.languageCode ==
                                            "en"
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  height: 50,
                                  padding: EdgeInsets.all(4),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: logic.phoneNumber,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(.2),
                                      filled: true,
                                      hintText: 'رقم الجوال',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ))
                            ]),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "ليس لديك حساب كموظف ؟",
                          style: PrimaryColornormalTextStylelLogin,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: logic.isLogIn?CircularProgressIndicator():CustomButton(
                            borderRadius: 10,fontWeight: FontWeight.w500,fontSize: 16,
                            width: MediaQuery.of(context).size.width * .8,
                            height: 50,
                            title: "تسجيل الدخول",
                            onClick: () {
                              logic.loginrequst(context);
                            },
                            buttonColor: ColorApp.PrimaryColor,
                            titleColor: ColorApp.WightColor),
                      ),SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "هل تحتاج الي مساعدة ؟",
                            style: TextStyle(color: ColorApp.greyColor),
                          ),
                      SizedBox(width: 8,),  Text(
                            "قم بزيارة مركز المساعدة",
                            style: PrimaryColornormalTextStylelLoginWithLine,
                          )  ],
                      )
                    ]),
              ),
            ));
          })
        ]),
      ),
    );
  }
}
