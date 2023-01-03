import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/network/apis/conutries_list_api.dart';
import 'package:bench_hr/network/apis/login_api.dart';
import 'package:bench_hr/network/apis/login_verify_api.dart';
import 'package:bench_hr/network/json_model/countries_model.dart';
import 'package:bench_hr/network/json_model/logIn_model.dart';
import 'package:bench_hr/network/json_model/logIn_verify_model.dart';
import 'package:bench_hr/utility/conest_image.dart';
import 'package:bench_hr/utility/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();

  //TextEditingController otpNumber = TextEditingController();
  String otpNumber = "";
  ConutriesListAPI conutriesListAPI = ConutriesListAPI();
  ScrollController scrollController = ScrollController();
  List<ConutriesList> conutriesList = [];
  CountriesModel? countriesModel;
  LogInModel? logInModel;
  String conutrieCode = "+966";
  String conutrieFlag = "SA";
  String phone_country_id = "156";
  bool isLogIn = false;
  bool isResendOTP = false;

  RxInt time = 30.obs;
bool phoneOnSelected=false;
  upDateTime() async {
    isResendOTP = true;
    update();
    while (time.value > 0) {
      await Future.delayed(Duration(seconds: 1));
      time.value--;
      print(time.value);
    }
    if (time.value == 0) {
      isResendOTP = false;
      update();
      time.value = 30;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getConutriesList();
    phoneNumber.text = "557175557";
  }

  Future buttomsheetCanteryList({
    required BuildContext context,
  }) async {
    Get.bottomSheet(GetBuilder<LogInController>(builder: (logic) {
      // assets/image/flags/AD.svg
      return Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0,left: 15,top: 4),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 2,
                  width: 30,
                  decoration:
                      BoxDecoration(color: ColorApp.greyIntroColor2.withOpacity(.5)),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Text("إختر كود الدولة",
                        style: TextStyle(
                            color: ColorApp.PrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         enabledBorder: OutlineInputBorder(
              //             borderSide: BorderSide(width: 3, color: Colors.grey)),),
              //   ),
              // ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16,top: 16,bottom: 8),
                    child: Text("الأكثر شيوعاً",
                        style: TextStyle(
                            color: ColorApp.greyIntroColor2,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    conutrieCode = "+966";
                    conutrieFlag = "SA";
                    phone_country_id = "156";
                    update();
                    Get.back();
                  },
                  child: Container(
                      decoration: BoxDecoration(border: Border.all(color: ColorApp.PrimaryColor.withOpacity(.1),),
                          color: Colors.green.withOpacity(.1),
                          borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/image/flags/SA.svg",
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("السعودية"),
                            Spacer(),
                            Text("+966")
                          ],
                        ),
                      ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8),
                child: GestureDetector(
                  onTap: () {
                    conutrieCode = "+2";
                    conutrieFlag = "EG";
                    phone_country_id = "55";
                    update();
                    Get.back();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      height: 40,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/image/flags/EG.svg",
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("مصر"),
                            Spacer(),
                            Text("+2")
                          ],
                        ),
                      ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Divider(
                    height: 1, color: ColorApp.grayDividerColor, thickness: 1),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16,bottom: 8),
                    child: Text("الكل",
                         style: TextStyle(
                        color: ColorApp.greyIntroColor2,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: conutriesList.length,
                    itemBuilder: (context, pos) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            conutrieCode = conutriesList[pos].code!;
                            conutrieFlag = conutriesList[pos].icon!;
                            phone_country_id = conutriesList[pos].id.toString();
                            update();
                            Get.back();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 40,
                              child: Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(right:16, left: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "${AppImage.imagePath}${conutriesList[pos].icon}.svg",
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("${conutriesList[pos].name}"),
                                    Spacer(),
                                    Text("${conutriesList[pos].code}")
                                  ],
                                ),
                              ))),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }));

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0)
          print('List scroll at top');
        else {
          getConutriespaginationList();
        }
      }
    });
  }

  getConutriespaginationList() {
    if (countriesModel!.data!.pagination!.next!.trim().isNotEmpty) {
      conutriesListAPI
          .getpaginationData(url: countriesModel!.data!.pagination!.next!)
          .then((value) {
        countriesModel = value as CountriesModel;

        conutriesList.addAll(countriesModel?.data?.list ?? []);
        update();
      });
    }
  }

  getConutriesList() {
    conutriesListAPI.getData().then((value) {
      countriesModel = value as CountriesModel;

      conutriesList.addAll(countriesModel?.data?.list ?? []);
      update();
    });
  }

  updateisResendOTP(bool val) {
    isResendOTP = val;
  }

  TimeForResendOTP() {
    isResendOTP = true;
    update();
  }

  LoginVerify() {
    LoginVerifyApi loginVerifyApi = LoginVerifyApi();

    Map<String, dynamic> data = {
      "phone": phoneNumber.text,
      "otp": otpNumber, //.text,
      "phone_country_id": phone_country_id
    };
    loginVerifyApi.post(data).then((value) {
      LogInVerifyModel logInVerifyModel = LogInVerifyModel.fromJson(value.data);

      SecureStorage.writeToken(logInVerifyModel.data!.token!);
      SecureStorage.writeCompany(logInVerifyModel.data!.user!.company!);
      SecureStorage.writeSecureJsonData(value: logInVerifyModel.toJson());

      Get.offAllNamed('/Home');
    });
  }

  //request OTP
  loginrequst(context) {
    //557175557
    Map<String, dynamic> data = {
      "phone": phoneNumber.text,
      "phone_country_id": phone_country_id
    };
    isLogIn = true;
    update();
    LoginApi loginApi = LoginApi();

    loginApi.post(data).catchError((e) {
      isLogIn = false;
      update();

      loginrequsterr();
      print("-----------------------------------------------------------");
    }).then((value) {
      LogInModel logInModel = LogInModel.fromJson(value.data);
      isLogIn = false;
      isloginrequstErr = false;
      update();
      Get.toNamed("/LogInVerifyScreen");
    });
  }

  bool isloginrequstErr = false;

  loginrequsterr() {
    isloginrequstErr = true;
    update();
  }
}
