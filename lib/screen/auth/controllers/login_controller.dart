import 'package:bench_hr/const/app_color.dart';
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
  TextEditingController otpNumber = TextEditingController();
  ConutriesListAPI conutriesListAPI = ConutriesListAPI();
  ScrollController scrollController = ScrollController();
  List<ConutriesList> conutriesList = [];
  CountriesModel? countriesModel;
  LogInModel? logInModel;
  String conutrieCode = "+966";
  String conutrieFlag = "SA";
  String phone_country_id = "156";
  bool isLogIn=false;
bool isResendOTP=false;


RxInt time=30.obs;
upDateTime()async{
  isResendOTP=true;
  update();
  while(time.value >0) {
  await Future.delayed(Duration(seconds: 1));
  time.value--;
  print(time.value);
  }
  if(time.value==0){
    isResendOTP=false;
    update();
    time.value=30;
  }

}

  @override
  void onInit() {
    super.onInit();
    getConutriesList();
    phoneNumber.text="557175557";
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
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 2,
                width: 100,
                decoration: BoxDecoration(color: ColorApp.PrimaryColor),
              ),
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    height: 40,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/image/flags/SA.svg",
                            width: 30,
                            height: 30,
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
              padding: const EdgeInsets.all(8.0),
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
                      padding: const EdgeInsets.only(right: 8.0, left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/image/flags/EG.svg",
                            width: 30,
                            height: 30,
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
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                  height: 1, color: ColorApp.PrimaryColor, thickness: 1),
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: conutriesList.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                  const EdgeInsets.only(right: 8.0, left: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "${AppImage.imagePath}${conutriesList[pos].icon}.svg",
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


updateisResendOTP(bool val){
  isResendOTP=val;

}
TimeForResendOTP(){
  isResendOTP=true;
  update();




}
  LoginVerify() {
    LoginVerifyApi loginVerifyApi = LoginVerifyApi();

    Map<String, dynamic> data = {
      "phone": phoneNumber.text,
      "otp":  otpNumber.text,
      "phone_country_id":phone_country_id
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
  loginrequst(context) {//557175557
    Map<String, dynamic> data = {"phone": phoneNumber.text,"phone_country_id":phone_country_id
    };
    isLogIn=true;
    update();
    LoginApi loginApi = LoginApi();
      loginApi.post(data).then((value) {


          LogInModel logInModel = LogInModel.fromJson(value.data);
          isLogIn=false;
          update();
          Get.toNamed("/LogInVerifyScreen");
        });

  }
}
