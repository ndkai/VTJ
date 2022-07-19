import 'package:get/get.dart';
import 'package:vkhealth/app/modules/timeoff/controllers/timeoff_controller.dart';

class TimeoffBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TimeOffController>(() => TimeOffController());
  }
}