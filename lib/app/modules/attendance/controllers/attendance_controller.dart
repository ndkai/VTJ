import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoweek/isoweek.dart';
import 'package:vkhealth/app/models/request_models/attendance/attendance_resquest.dart';
import 'package:vkhealth/app/models/request_models/attendance/manuala_reuquest.dart';
import 'package:vkhealth/app/models/request_models/employees/employees_requets.dart';
import 'package:vkhealth/app/models/response_models/attendance/attendance_detailed.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';
import 'package:vkhealth/app/models/response_models/attendance/schedule_swagger.dart';
import 'package:vkhealth/app/models/response_models/attendance/shift_response.dart';
import 'package:vkhealth/app/models/response_models/user/employee_swagger.dart';
import 'package:vkhealth/app/repositories/attendance_repository.dart';
import 'package:vkhealth/app/services/auth_service.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/request_models/attendance/all_schedule_request.dart';
import '../../../models/request_models/attendance/create_shift_request.dart';
import '../../../models/request_models/attendance/over_time_request.dart';
import '../../../models/user_model.dart';

class AttendanceController extends GetxController {
  AttendanceRepository _attendanceRepository;
  final Rx<User> currentUser = Get.find<AuthService>().user;
  //attendance view overall
  final currentWeek = Week.current().obs;
  final currentScheduleGroup = ScheduleGroup().obs;
  final chooseShift = ShiftData().obs;
  RxList<EmployeeAttendance> employeesAttendance = <EmployeeAttendance>[].obs;
  RxList<ScheduleGroup> scheduleGroup = <ScheduleGroup>[].obs;
  final getAttendanceLoading = false.obs;

  //create schedule, overtime
  final employees = EmployeeSwagger(data: []).obs;
  final shiftResponse = ShiftResponse().obs;
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().add(const Duration(days: 1)).obs;
  final getEmployeeLoading = false.obs;
  final loadMoreEmployee = false.obs;
  int pageIndex = 0;
  final ScrollController employeeScrollCl = ScrollController();
  final chooseAll = false.obs;
  final startTime = TimeOfDay.now().obs;
  final endTime = TimeOfDay.now().obs;
  final mealSignUp = true.obs;
  final factor = "1.0".obs;
  final overtimeCheck = false.obs;
  TextEditingController chooseScheduleCl = TextEditingController();
  TextEditingController chooseScheduleGroupCl = TextEditingController();
  final dayoffWeek = [
    0,
    1,
    2,
    3,
    4,
    5,
  ].obs;

  //detailed attendance
  final attendanceDetailSwagger = AttendanceDetailSwagger().obs;
  final attendanceDetailedLoading = false.obs;

  AttendanceController() {
    _attendanceRepository = AttendanceRepository();
  }

  Future<void> overTimeBatch(
    BuildContext context,
  ) async {
    if (fromDate.value.difference(toDate.value).inDays > 0) {
      Get.showSnackbar(Ui.RemindSnackBar(
          message: "Thời gian kết thúc phải sau thời gian bắt đầu"));
      return;
    }
    if (dayoffWeek.isEmpty) {
      Get.showSnackbar(
          Ui.RemindSnackBar(message: "Lịch trong tuần không được trống"));
      return;
    }
    if (employees.value.data
        .where((element) => element.isChoose)
        .toList()
        .isEmpty) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn nhân viên nào"));
      return;
    }
    try {
      if (Helper.hourComparison(startTime.value, endTime.value)) {
        Get.showSnackbar(Ui.RemindSnackBar(
            message: "Thời gian kết thúc phải trước thời gian bắt đầu"));
        return;
      }
      await _attendanceRepository.overTimeBatch(OverallScheduleRequest(
          fromDate: fromDate.value.toIso8601String(),
          toDate: toDate.value.toIso8601String(),
          employeeIds:
              employees.value.data.map((element) => element.id).toList(),
          daysOfWeek: dayoffWeek,
          overtimeShift: OvertimeShift(
              factor: factor.value,
              timeBegin: Helper.getHour(startTime.value),
              timeEnd: Helper.getHour(endTime.value),
              isAutomaticallyRegisterMeal: mealSignUp.value,
              type: 0,
              workingHours: endTime.value.hour - startTime.value.hour)));
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Tạo thành công"));
      chooseShift.value = shiftResponse.value.data.first;
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Tạo thất bại"));
    } finally {
      Navigator.of(context).pop();
      employees.value.data.clear();
      getEmployeesAttendance(context);
    }
  }

  Future<void> overallCreateSchedule(
    BuildContext context,
  ) async {
    if (chooseShift.value.name == null) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn ca"));
      return;
    }
    if (fromDate.value.difference(toDate.value).inDays > 0) {
      Get.showSnackbar(Ui.RemindSnackBar(
          message: "Thời gian kết thúc phải sau thời gian bắt đầu"));
      return;
    }
    if (dayoffWeek.isEmpty) {
      Get.showSnackbar(
          Ui.RemindSnackBar(message: "Lịch trong tuần không được trống"));
      return;
    }
    if (employees.value.data
        .where((element) => element.isChoose)
        .toList()
        .isEmpty) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn nhân viên nào"));
      return;
    }
    try {
      if (overtimeCheck.value) {
        if (Helper.hourComparison(startTime.value, endTime.value)) {
          Get.showSnackbar(Ui.RemindSnackBar(
              message: "Thời gian kết thúc phải trước thời gian bắt đầu"));
          return;
        }
        await _attendanceRepository.overallCreateSchedule(
            OverallScheduleRequest(
                shiftId: chooseShift.value.id,
                fromDate: fromDate.value.toIso8601String(),
                toDate: toDate.value.toIso8601String(),
                employeeIds: employees.value.data
                    .where((element) => element.isChoose)
                    .map((element) => element.id)
                    .toList(),
                daysOfWeek: dayoffWeek,
                overtimeShift: OvertimeShift(
                    factor: factor.value,
                    timeBegin: Helper.getHour(startTime.value),
                    timeEnd: Helper.getHour(endTime.value),
                    isAutomaticallyRegisterMeal: mealSignUp.value,
                    type: 1,
                    workingHours: endTime.value.hour - startTime.value.hour)));
      } else {
        await _attendanceRepository
            .overallCreateSchedule(OverallScheduleRequest(
          shiftId: chooseShift.value.id,
          fromDate: fromDate.value.toIso8601String(),
          toDate: toDate.value.toIso8601String(),
          employeeIds: employees.value.data
              .where((element) => element.isChoose)
              .map((element) => element.id)
              .toList(),
          daysOfWeek: dayoffWeek,
        ));
      }

      chooseShift.value = shiftResponse.value.data.first;
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Tạo thành công"));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Tạo thất bại"));
    } finally {
      Navigator.of(context).pop();
      employees.value.data.clear();
      getEmployeesAttendance(context);
    }
  }

  Future<void> getShift() async {
    try {
      shiftResponse.value = await _attendanceRepository.getShift();
      chooseShift.value = shiftResponse.value.data.first;
    } finally {}
  }

  Future<void> createSchedule(
      BuildContext context, EmployeeAttendance employeeAttendance) async {
    try {
      // showLoadingDialog(context);
      if (overtimeCheck.value) {
        if (Helper.hourComparison(startTime.value, endTime.value)) {
          Get.showSnackbar(Ui.RemindSnackBar(
              message: "Thời gian kết thúc phải trước thời gian bắt đầu"));
          return;
        }
        await _attendanceRepository.createSchedule(CreateScheduleRequest(
            employeeId: employeeAttendance.employee.id,
            date: fromDate.value.toIso8601String(),
            shiftId: chooseShift.value.id,
            overtimeShift: OvertimeShift(
                factor: factor.value,
                type: 1,
                workingHours: endTime.value.hour - startTime.value.hour,
                timeBegin: Helper.getHour(startTime.value),
                timeEnd: Helper.getHour(endTime.value),
                isAutomaticallyRegisterMeal: mealSignUp.value)));
      } else {
        await _attendanceRepository.createSchedule(CreateScheduleRequest(
            employeeId: employeeAttendance.employee.id,
            date: fromDate.value.toIso8601String(),
            shiftId: chooseShift.value.id));
      }

      Get.showSnackbar(Ui.SuccessSnackBar(message: "Tạo lịch thành công"));
      getEmployeesAttendance(context);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Tạo lịch thất bại"));
    } finally {
      Navigator.of(context).pop();
      getEmployeesAttendance(context);
    }
  }

  Future<void> deleteSchedule(BuildContext context, String id) async {
    try {
      // showLoadingDialog(context);
      await _attendanceRepository.deleteSchedule(id);
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Xóa thành công"));
      getEmployeesAttendance(context);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Xóa thất bại"));
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<void> overtimeSignUpWhenHaveSchedule(
      BuildContext context, Attendances attendances) async {
    try {
      // showLoadingDialog(context);
      List<String> shiftTime = attendances.schedule.shift.timeBegin.split("");
      if (Helper.hourComparison(startTime.value, endTime.value)) {
        Get.showSnackbar(Ui.RemindSnackBar(
            message: "Thời gian kết thúc phải trước thời gian bắt đầu"));
        return;
      }
      if (!Helper.hourComparison(
          startTime.value,
          TimeOfDay(
              hour: int.parse(shiftTime.first),
              minute: int.parse(shiftTime[1])))) {
        Get.showSnackbar(Ui.RemindSnackBar(
            message: "Thời gian bắt đầu phải sau ca làm việc chính"));
        return;
      }

      await _attendanceRepository.overtimeSignUp(OverTimeRequest(
          factor: factor.value,
          id: attendances.schedule.id,
          isAutomaticallyRegisterMeal: mealSignUp.value,
          type: 1,
          timeBegin: Helper.getHour(startTime.value),
          timeEnd: Helper.getHour(endTime.value),
          workingHours: endTime.value.hour - startTime.value.hour));
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Đăng kí thành công"));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      getEmployeesAttendance(context);
    }
  }

  Future<void> attendanceManual(BuildContext context,
      {String note,
      String employeeId,
      DateTime ciTime,
      DateTime coTime,
      String id,
      String date}) async {
    try {
      // showLoadingDialog(context);
      await _attendanceRepository.attendanceManual(EmployeeManualRequest(
          checkIn: ciTime.toIso8601String(),
          checkOut: coTime.toIso8601String(),
          employeeId: employeeId,
          note: note));
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Tạo thành công"));
      getAttendanceDetailed(context, id, date);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {}
  }

  Future<void> getEmployeesAttendance(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      getAttendanceLoading.value = true;
      employeesAttendance.value =
          await _attendanceRepository.getEmployeeAttendance(
              Helper.getApiDate(currentWeek.value.days.first),
              Helper.getApiDate(currentWeek.value.days.last),
              currentScheduleGroup.value.id,
              "");
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      getAttendanceLoading.value = false;
    }
  }

  Future<void> get1EmployeesAttendance(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      getAttendanceLoading.value = true;
      employeesAttendance.value =
          await _attendanceRepository.getEmployeeAttendance(
              Helper.getApiDate(currentWeek.value.days.first),
              Helper.getApiDate(currentWeek.value.days.last),
              currentScheduleGroup.value.id,
              currentUser.value.userInfo.employee.code);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      getAttendanceLoading.value = false;
    }
  }

  Future<void> getAttendanceDetailed(
      BuildContext context, String id, String date) async {
    try {
      // showLoadingDialog(context);
      attendanceDetailedLoading.value = true;
      attendanceDetailSwagger.value =
          await _attendanceRepository.getAttendanceDetailed(
              AttendanceRequest(id: id, fromDate: date, toDate: date));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      attendanceDetailedLoading.value = false;
    }
  }

  Future<void> getScheduleGroup(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      scheduleGroup.value = await _attendanceRepository.getScheduleGroup();
      currentScheduleGroup.value = scheduleGroup.first;
      getEmployeesAttendance(context);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      // Navigator.of(context).pop();
    }
  }

  Future<void> getEmployees() async {
    if (employees.value.data.isEmpty) {
      getEmployeeLoading.value = true;
    }
    try {
      var e = await _attendanceRepository.getEmployees(GetEmployeeRequest(
        pageIndex: pageIndex,
        pageSize: 10,
      ));
      for (var i in e.data) {
        i.isChoose = chooseAll.value;
      }
      employees.value.data.addAll(e.data);

      employees.refresh();
      pageIndex++;
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loadMoreEmployee.value = false;
      getEmployeeLoading.value = false;
    }
  }

  Future<void> getEmployeesByName(String keyword) async {
    try {
      employees.value.data.clear();
      getEmployeeLoading.value = true;
      var e = await _attendanceRepository.getEmployees(
          GetEmployeeRequest(keyword: keyword, pageIndex: 0, pageSize: 10000));
      employees.value.data.addAll(e.data);
      employees.refresh();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loadMoreEmployee.value = false;
      getEmployeeLoading.value = false;
    }
  }
}
