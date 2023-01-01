
import 'package:bench_hr/screens/auth/controllers/login_controller.dart';
import 'package:get/get.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(  LogInController(),permanent: true) ;


  }
}
