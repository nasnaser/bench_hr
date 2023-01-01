import 'package:bench_hr/utility/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



class AuthMiddleWare extends GetMiddleware {
 // final SecureStorage _secureStorage = SecureStorage();

  @override
  RouteSettings? redirect(String? route) {
    print("token in start ${SecureStorage.readToken()}");
    if (SecureStorage.readToken() != null) {
      return const RouteSettings(name: "/Home");

    }
  }
}
