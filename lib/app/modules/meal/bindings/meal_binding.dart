import 'package:get/get.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';

class MealBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MealController>(() => MealController());
  }

}