import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../models/response_models/attendance/schedule_swagger.dart';
import '../../../repositories/meal_repository.dart';

class MealController extends GetxController{
  final selectedStatic = 0.obs;
  final currentDate = DateTime.now().obs;
  RxList<ScheduleGroup> scheduleGroup =  <ScheduleGroup>[].obs;
  final currentScheduleGroup = ScheduleGroup().obs;

  MealRepository _mealRepository;

  MealController(){
    _mealRepository = MealRepository();
  }

  Future<void> getScheduleGroup(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      scheduleGroup.value = await _mealRepository.getScheduleGroup();
      currentScheduleGroup.value = scheduleGroup.first;
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      // Navigator.of(context).pop();
    }
  }
}