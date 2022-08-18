
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoweek/isoweek.dart';
import 'package:vkhealth/app/models/request_models/timeoff/time_off_request.dart';
import 'package:vkhealth/app/models/response_models/timeoff/responses/employee_timeoff.dart' as time_off;
import 'package:vkhealth/app/repositories/timeoff_repository.dart';
import 'package:vkhealth/app/routes/app_routes.dart';

import '../../../../common/ui.dart';
import '../../../models/request_models/employees/employees_requets.dart';
import '../../../models/request_models/timeoff/time_off_type.dart';
import '../../../models/response_models/user/employee_swagger.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/dialog/success_dialog.dart';

class TimeOffController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().obs;
  final currentWeek = Week.current().obs;
  final TextEditingController noteCl = TextEditingController();
  final timeOfType = TimeOffType().obs;
  final currentTimeOffType = TimeOffTypeData().obs;
  TextEditingController currentTimeOffTypeCl = TextEditingController(text: "Chọn loại nghỉ phép");
  BuildContext context;
  RxList<time_off.EmployeeTimeOff> employeesTimeOff=  <time_off.EmployeeTimeOff>[].obs;
  final employees = EmployeeSwagger(data: []).obs;
  final getEmployeeLoading = false.obs;
  final getEmployeeTOLoading = false.obs;
  final loadMoreEmployee = false.obs;
  int pageIndex = 0;
  final ScrollController employeeScrollCl = ScrollController();
  final chooseAll = false.obs;


  TimeOffRepository _timeOffRepository;

  TimeOffController() {
    _timeOffRepository = TimeOffRepository();
  }

  Future<void> getTimeOffType() async {
    try{
      timeOfType.value = await _timeOffRepository.getTimeOffType();
    } catch(e){
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString().replaceAll("Exception: ", "")));
    } finally{
    }
  }


  Future<void> getEmployeeTimeOff(BuildContext context) async {
    try{
      getEmployeeTOLoading.value = true;
      employeesTimeOff.value = await _timeOffRepository.
      getEmployeeTimeOff(currentWeek.value.days.first.toIso8601String(),currentWeek.value.days.last.toIso8601String(), 0,
          code: currentUser.value.userInfo.employee != null ? currentUser.value.userInfo.employee.code : '')  ;
    } catch(e){
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString().replaceAll("Exception: ", "")));
    } finally{
      getEmployeeTOLoading.value = false;
    }
  }

  Future<void> postTimeOff() async {
    try{
      if(currentTimeOffType.value.id == null){
        Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn loại nghỉ phép"));
        return;

      }
      var timeOffRequest = PostTimeOffRequest(
        employeeId: currentUser.value.userInfo.employee.id,
        fromDate: fromDate.value.toIso8601String(),
        toDate:  toDate.value.toIso8601String(),
        timeOffTypeId: currentTimeOffType.value.id,
        note: noteCl.text,
        isAbsenteeism: true,
        sign: ""
      );
      await _timeOffRepository.postTimeOff(timeOffRequest);
      Navigator.of(context).pop();
      showAppSuccesDialog(context, title: "Xác nhận tạo đơn nghỉ phép thành công", homepageTap: (){
        Get.offAllNamed(Routes.ROOT);
      },
      historyTap: (){
        Get.offNamedUntil(Routes.TIMEOFF, ModalRoute.withName(Routes.ROOT));
      });
    } catch(e){
      Navigator.of(context).pop();
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString().replaceAll("Exception: ", "")));
    }
  }
  
  Future<void> adminPostTimeOff() async {
    try{
      if(employees.value.data.firstWhere((element) => element.isChoose) == null){
        Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn nhân viên nào"));
        return;
      }

      if(currentTimeOffType.value.description == null){
        Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn lại nghỉ phép"));
        return;
      }
      var timeOffRequest = PostTimeOffRequest(
        employeeId: employees.value.data.firstWhere((element) => element.isChoose).id,
        fromDate: fromDate.value.toIso8601String(),
        toDate:  toDate.value.toIso8601String(),
        timeOffTypeId: currentTimeOffType.value.id,
        note: "",
        isAbsenteeism: true,
        sign: ""
      );
      await _timeOffRepository.postTimeOff(timeOffRequest);
      Navigator.of(context).pop();
      showAppSuccesDialog(context, title: "Xác nhận tạo đơn nghỉ phép thành công", homepageTap: (){
        Get.offAllNamed(Routes.ROOT);
      },
      historyTap: (){
        Get.offNamedUntil(Routes.TIMEOFF, ModalRoute.withName(Routes.ROOT));
      });
    } catch(e){
      Navigator.of(context).pop();
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


  Future<void> getEmployees() async {
    if(employees.value.data.isEmpty){
      getEmployeeLoading.value = true;
    }
    try {
      var e = await _timeOffRepository.getEmployees(GetEmployeeRequest(
        pageIndex: pageIndex,
        pageSize: 10,
      ));
      for(var i in e.data){
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
      var e = await _timeOffRepository.getEmployees(GetEmployeeRequest(
          keyword: keyword,
          pageIndex: 0,
          pageSize: 10000
      ));
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
