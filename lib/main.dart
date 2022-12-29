import 'package:bench_hr/screen/auth/binding/login_binding.dart';
import 'package:bench_hr/screen/auth/login_screen.dart';
import 'package:bench_hr/screen/auth/login_verify_screen.dart';
import 'package:bench_hr/screen/auth/middleware/auth_middleware.dart';
import 'package:bench_hr/screen/home/binding/home_binding.dart';
import 'package:bench_hr/screen/home/home.dart';
import 'package:bench_hr/screen/introduction_screen/binding/intro_binding.dart';
import 'package:bench_hr/screen/introduction_screen/intro_screen.dart';
import 'package:bench_hr/screen/introduction_screen/middleware/Intro_middleware.dart';
import 'package:bench_hr/translation/trans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: LocalizationService.locale,
      translations: LocalizationService(),
      fallbackLocale: LocalizationService.fallbackLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ArbFONTS',
      ),
      initialRoute: "/intro",
      getPages: [
        GetPage(
            name: "/intro",
            page: () => IntroScreen(),
            binding: IntroBinding(),
            middlewares: [IntroMiddleWare()]),
        GetPage(
            name: "/login",
            page: () => LogInScreen(),
            binding: LogInBinding(),
            middlewares: [AuthMiddleWare()]),
        GetPage(
          name: "/LogInVerifyScreen", page: () => LogInVerifyScreen(),
          binding: LogInBinding(),
          // middlewares: [
          //   AuthMiddleWare()
          // ]
          //
          // )
        ),
        GetPage(
            name: "/Home", page: () => HomeScreen(), binding: HomeBinding()),
      ],
    );
  }
}
