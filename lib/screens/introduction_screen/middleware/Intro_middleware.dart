import 'package:bench_hr/utility/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroMiddleWare extends GetMiddleware {


  @override
  RouteSettings? redirect(String? route) {

    if (SecureStorage.readIntro() != null) {
      return const RouteSettings(name: "/login");
    }
  }
}
