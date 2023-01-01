
import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/constants/styles.dart';
import 'package:bench_hr/screens/auth/controllers/login_controller.dart';
import 'package:bench_hr/screens/shared_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LogInVerifyScreen extends GetView<LogInController> {

  @override
  Widget build(BuildContext context) {
    controller.otpNumber= TextEditingController();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorApp.PrimaryColor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [ SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 8),
                child: Row(
                  children: [
                    Text(
                      "رمز التحقق",
                      style: normalWightColorTextStyle,
                    ),
                  ],
                ),
              ), SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "أدخل رمز التحقق لبدء استخدام بينش.",
                  style: normalWightColorTextStylelLOgin,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GetBuilder<LogInController>(autoRemove: false,builder: (logic) {
                return Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                          color: ColorApp.WightColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "أدخل رمز التحقق المرسل إلى ",
                                    style: normalPrimaryColorTextStyle,
                                  ),
                                  Text(
                                    "${logic.conutrieCode}${logic.phoneNumber
                                        .text}",
                                    style: normalPrimaryColorTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              PinCodeTextField(keyboardType:TextInputType.number ,autoFocus: true,
                                length: 6,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    disabledColor: Colors.white,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white,
                                    activeFillColor: Colors.white,
                                    inactiveFillColor: ColorApp.otpColorBack),
                                animationDuration: Duration(milliseconds: 300),
                                //backgroundColor: Colors.blue.shade50,
                                enableActiveFill: true,
                                enablePinAutofill: true,
                                //cursorColor: Colors.teal,

                                controller: logic.otpNumber,
                                onCompleted: (v) {},
                                onChanged: (value) {},
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                                appContext: context,
                              ),
                              logic.isResendOTP ? Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "سوف يتم إعادة إرسال رمز التحقق خلال ",
                                        style: grayintroColornormal,
                                      ),
                                      Obx(() {
                                        return Text("${controller.time.value} :00 ثانية",
                                          style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w400,
                                              color: ColorApp.SecondaryColor),);
                                      })
                                    ],
                                  )

                              ) : Center(
                                child: Text(
                                  "لم يتم إستقبال رمز التحقق ؟",
                                  style: grayintroColornormal,
                                ),
                              ),
                              if(!logic.isResendOTP ) Center(
                                child: GestureDetector(onTap: () {
                                  logic.upDateTime();
                                },
                                  child: Text(
                                    "إعادة إرسال",
                                    style: resendOTPTextColor,
                                  ),
                                ),
                              ),


                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: logic.isLogIn
                                    ? CircularProgressIndicator()
                                    : CustomButton(
                                    borderRadius: 10,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .8,
                                    height: 50,
                                    title: "تحقق",
                                    onClick: () {
                                      logic.LoginVerify();
                                    },
                                    buttonColor: ColorApp.PrimaryColor,
                                    titleColor: ColorApp.WightColor),
                              ),
                              SizedBox(
                                height: 8,
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
                                    style: PrimaryColornormalTextStylelLoginWithLine,
                                  )
                                ],
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
