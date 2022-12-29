


import 'package:bench_hr/screen/home/controllers/home_controller.dart';
import 'package:bench_hr/screen/introduction_screen/intro_controller/introduction_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController(), fenix: true) ;


  }
}
