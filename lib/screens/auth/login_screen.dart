import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/constants/styles.dart';
import 'package:bench_hr/screens/auth/controllers/login_controller.dart';
import 'package:bench_hr/screens/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../network/json_model/emoji_json_model.dart';
import '../../utility/conest_image.dart';

class LogInScreen extends GetView<LogInController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorApp.PrimaryColor,
          body: Stack(
            children: [
              Image.asset('assets/image/backlogin.png'),
              Column(
                children: [
                  Column(
                    children: [

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 24, left: 24, top: 40),
                            child: Text(
                              "تسجيل الدخول",
                              style: normalWightColorTextStyle,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(  right: 24, left: 24, top: 8),
                            child: Text(
                              "أدخل رقم جوالك لبدء استخدام بينش.",
                              style: normalWightColorTextStylelLOgin,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "سنقوم بإرسال رمز التحقيق إلى رقم جوالك",
                                style: normalPrimaryColorTextStyle,
                              ),
                              SizedBox(
                                height: 26,
                              ),
                              GetBuilder<LogInController>(builder: (logic) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.buttomsheetCanteryList(
                                        context: context);
                                    // controller.  shhhh(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: logic.phoneOnSelected? ColorApp.PrimaryColor:Colors.white10,
                                        ),color:  ColorApp.inputColor),
                                    child: Row(children: [
                                      Expanded(
                                        flex: 1,
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
                                              style: TextStyle(
                                                  color: logic.isloginrequstErr
                                                      ? ColorApp.SecondaryColor
                                                      : Colors.black,fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),Icon(Icons.keyboard_arrow_down,color: Colors.grey,size: 20),
                                 SizedBox(width: 8,),  Container(height: 15,width: 1,color: Colors.grey.withOpacity(.5),),   Expanded(
                                          flex: 2,
                                          child: TextField(onTap: (){
                                            logic.phoneOnSelected=true;
                                            logic.update();
                                          },
                                            style: TextStyle(
                                                color: logic.isloginrequstErr
                                                    ? ColorApp.SecondaryColor
                                                    : Colors.black),
                                            controller: logic.phoneNumber,
                                            decoration: InputDecoration(
                                              fillColor: Colors.transparent,
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
                              if (logic.isloginrequstErr)
                                Text(
                                  "رقم الهاتف غير مسجل",
                                  style:
                                      TextStyle(color: ColorApp.SecondaryColor),
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
                                child: logic.isLogIn
                                    ? CircularProgressIndicator(color: ColorApp.PrimaryColor,)
                                    : CustomButton(
                                        borderRadius: 10,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        width:double.infinity,
                                        height: 50,
                                        title: "تسجيل الدخول",
                                        onClick: () {
                                          logic.loginrequst(context);
                                        },
                                        buttonColor: ColorApp.PrimaryColor,
                                        titleColor: ColorApp.WightColor),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "هل تحتاج الي مساعدة ؟",
                                    style: TextStyle(color: ColorApp.greyColor),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "قم بزيارة مركز المساعدة",
                                    style:
                                        PrimaryColornormalTextStylelLoginWithLine,
                                  )
                                ],
                              )
                            ]),
                      ),
                    ));
                  })
                ],
              ),
            ],
          )),
    );
  }
}
