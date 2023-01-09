

import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controller/attendace_controller.dart';

class AttendaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> AttendaceController(), ) ;


  }
}
