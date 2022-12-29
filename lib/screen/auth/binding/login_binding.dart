
import 'package:bench_hr/screen/auth/controllers/login_controller.dart';
import 'package:get/get.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogInController(),fenix: true) ;


  }
}
