import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';
import 'package:vkhealth/app/models/response_models/attendance/schedule_swagger.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/loading_dialog.dart';
import 'package:vkhealth/app/repositories/attendance_repository.dart';

import '../../../../common/ui.dart';

class AttendanceController extends GetxController{

  AttendanceRepository _attendanceRepository;
  
  final currentDate = DateTime.now().obs;
  RxList<EmployeeAttendance> employeesAttendance =  <EmployeeAttendance>[].obs;
  RxList<ScheduleGroup> scheduleGroup =  <ScheduleGroup>[].obs;

  AttendanceController(){
    _attendanceRepository = AttendanceRepository();
  }

  Future<void> getEmployeesAttendance(BuildContext context, String scheduleGroupId) async {
    try {
      // showLoadingDialog(context);
      employeesAttendance.value = await _attendanceRepository.getEmployeeAttendance('2020-7-11', '2020-7-17', "83e62198-5b04-4a66-a31b-4de3dcebb05b");
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      // Navigator.of(context).pop();
    }
  }

  Future<void> getScheduleGroup(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      scheduleGroup.value = await _attendanceRepository.getScheduleGroup();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      // Navigator.of(context).pop();
    }
  }

}