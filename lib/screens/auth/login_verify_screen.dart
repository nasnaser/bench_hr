
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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorApp.PrimaryColor,
        body: Stack(
          children: [   Image.asset('assets/image/backlogin.png'),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 24, top: 40),
                    child: Row( crossAxisAlignment: CrossAxisAlignment.end,
                      children: [GestureDetector(onTap: (){
                        Get.back();
                      },child: Icon(Icons.arrow_back,color: Colors.white,)),SizedBox(width: 4,),
                        Text(
                          "رمز التحقق",textAlign: TextAlign.start,
                          style: normalWightColorTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 24, top: 8),
                    child: Text(
                      "أدخل رمز التحقق لبدء استخدام بينش.",
                      style: normalWightColorTextStylelLOgin,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GetBuilder<LogInController>(autoRemove: false,builder: (logic) {
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
                                  Row(
                                    children: [
                                      Text(
                                        "أدخل رمز التحقق المرسل إلى ",
                                        style: TextStyle(  fontSize: 16,
                                          fontWeight: FontWeight.w400,),
                                      ),
                                      Text(
                                        "${logic.conutrieCode}${logic.phoneNumber
                                            .text}",
                                        style: normalPrimaryColorTextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  PinCodeTextField(keyboardType:TextInputType.number ,autoFocus: true,
                                    length: 6,
                                    obscureText: false,
                                    animationType: AnimationType.fade,
                                    pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(12),
                                        fieldHeight: 50,
                                        fieldWidth: 50,selectedFillColor: Colors.white,
                                        disabledColor: Colors.white,
                                        activeColor: Colors.white,selectedColor: ColorApp.PrimaryColor,
                                        inactiveColor: Colors.white,
                                        activeFillColor: Colors.white,
                                        inactiveFillColor: ColorApp.otpColorBack),
                                    animationDuration: Duration(milliseconds: 300),
                                    //backgroundColor: Colors.blue.shade50,
                                    enableActiveFill: true,
                                    enablePinAutofill: true,
                                    //cursorColor: Colors.teal,

                                  // controller: logic.otpNumber,
                                    onCompleted: (v) {
                                    print("ooooooooooooooooooo$v");
                                     controller.otpNumber=v;
                                    },
                                    onChanged: (value) {
                                    print(value);
                                     // controller.otpNumber.text=value;
                                    },
                                    beforeTextPaste: (text) {
                                      print("Allowing to paste $text");
                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                      return false;
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
                                      style: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: ColorApp.greyIntroColor2,),
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
                                        style: PrimaryColornormalTextStylelLoginWithLine,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ));
                  })
                ]),
          ],
        ),
      ),
    );
  }
}
