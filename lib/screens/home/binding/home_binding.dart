

import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController(), fenix: true) ;


  }
}
