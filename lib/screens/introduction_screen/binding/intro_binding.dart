

import 'package:bench_hr/screens/introduction_screen/intro_controller/introduction_controller.dart';
import 'package:get/get.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroController()) ;


  }
}
