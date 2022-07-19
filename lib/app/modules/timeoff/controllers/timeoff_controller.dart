import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/timeoff/responses/employee_timeoff.dart' as time_off;
import 'package:vkhealth/app/repositories/timeoff_repository.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';

class TimeOffController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().obs;
  RxList<time_off.EmployeeTimeOff> employeesTimeOff=  <time_off.EmployeeTimeOff>[].obs;

  TimeOffRepository _timeOffRepository;

  TimeOffController() {
    _timeOffRepository = TimeOffRepository();
  }

  Future<void> getEmployeeTimeOff() async {
    try{
      employeesTimeOff.value = await _timeOffRepository.getEmployeeTimeOff("2022-03-10","2023-03-10", 0);
    } catch(e){
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString().replaceAll("Exception: ", "")));
    }
  }

  String mapStatusToState(int status){
     switch(status) {
       case 0:
         return "Tạo đơn";
       case 1:
        return "Chờ duyệt";
       case 2:
         return "Hủy";
       case 3:
         return "Chấp nhận";
       case 4:
         return "Từ chối";
     }
     return "";
       
  }

  Color mapStatusToColor(int status){
     switch(status) {
       case 0:
         return Colors.black;
       case 1:
        return Colors.orange;
       case 2:
         return Colors.red;
       case 3:
         return Colors.green;
       case 4:
         return Colors.brown;
     }
     return Colors.black;

  }
}
