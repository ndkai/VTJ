import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:vkhealth/app/models/request_models/meal/batch_for_anonymous.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_shift.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_statistic.dart';
import 'package:vkhealth/app/models/request_models/meal/small_unit_swagger.dart';
import 'package:vkhealth/app/models/response_models/meal/meal_overview.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/loading_dialog.dart';
import 'package:vkhealth/common/app_constant.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../models/request_models/employees/employees_requets.dart';
import '../../../models/request_models/meal/meal_batch_request.dart';
import '../../../models/request_models/meal/meal_request.dart';
import '../../../models/request_models/meal/meal_sign_up-reuquest.dart';
import '../../../models/response_models/attendance/schedule_swagger.dart';
import '../../../models/response_models/user/employee_swagger.dart';
import '../../../repositories/meal_repository.dart';

class MealController extends GetxController {
  final selectedStatic = 0.obs;
  final selectedSign = 0.obs;
  final getMealOverviewLoading = false.obs;
  final currentDate = DateTime.now().obs;
  final chooseAll = false.obs;
  final fromDate = DateTime.now().obs;
  final toDate = DateTime.now().add(const Duration(days: 1)).obs;
  final getEmployeeLoading = false.obs;
  final loadMoreEmployee = false.obs;
  final mealStatisticLoading = false.obs;
  int pageIndex = 0;
  final ScrollController employeeScrollCl = ScrollController();
  final TextEditingController chooseScheduleCl = TextEditingController();
  final TextEditingController chooseMealTypeCl = TextEditingController();
  final TextEditingController amountCl = TextEditingController();
  final TextEditingController chooseUnitTypeCl =
      TextEditingController(text: AppConstants.appUnits.first.name);
  final TextEditingController chooseSmallUnitTypeCl = TextEditingController();
  final employees = EmployeeSwagger(data: []).obs;
  final mealOverView = MealOverView().obs;
  final mealStatistic = MealStatistic().obs;
  final smallUnitSwagger = SmallUnitSwagger().obs;
  final currentSmallUnit = SmallUnit().obs;
  final currentUnit = AppConstants.appUnits.first.obs;
  RxList<ScheduleGroup> scheduleGroup = <ScheduleGroup>[].obs;
  final currentScheduleGroup = ScheduleGroup().obs;
  Rx<MealShift> chooseShift = MealShift("", 0).obs;
  MealRepository _mealRepository;

  MealController() {
    _mealRepository = MealRepository();
  }

  Future<void> batchForAnonymous(BuildContext context) async {
    if (currentSmallUnit.value.id == null || currentSmallUnit.value == null) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn đơn vị"));
      return;
    }

    if (chooseShift.value.id == null || chooseShift.value == null) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn ca"));
      return;
    }

    if (chooseMealTypeCl.text.isEmpty) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa chọn loại cơm"));
      return;
    }

    if (amountCl.text.isEmpty) {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Chưa nhập số lượng"));
      return;
    }
    try {
      showLoadingDialog(context);
      await _mealRepository.batchForAnonymous(BatchForAnonymousRequest(
          date: fromDate.value.toIso8601String(),
          unitId: currentSmallUnit.value.id,
          meals: [
            Meall(
                shiftType: chooseShift.value.id,
                mealType: chooseMealTypeCl.text == "Cơm mặn" ? 1 : 0,
                total: int.parse(amountCl.text),
                id: const Uuid().v4())
          ]));
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Tạo bổ sung thành công"));
    } catch (e) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Tạo thất bại"));
    } finally {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  Future<void> getSmallUnit(BuildContext context, int id) async {
    try {
      smallUnitSwagger.value = await _mealRepository.getSmallUnit(id);
    } finally {}
  }

  Future<void> getMealStatistic(BuildContext context) async {
    try {
      mealStatisticLoading.value = true;
      mealStatistic.value = await _mealRepository.getMealStatistic();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      mealStatisticLoading.value = false;
    }
  }

  Future<void> comfirmSignUp(BuildContext context) async {
    try {
      showLoadingDialog(context);
      await _mealRepository.confirmMeal(MealBatchRequest(
        date: fromDate.value.toIso8601String(),
        employeeIds: mealOverView.value.data
            .where((element) => element.isChoose)
            .map((e) => e.employee.id)
            .toList(),
      ));
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Xác nhận thành công"));
      getOverviewMeal(context);
      Navigator.pop(context);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      Navigator.pop(context);
    } finally {}
  }

  Future<void> riceSignup(BuildContext context) async {
    try {
      showLoadingDialog(context);
      await _mealRepository.postMeal4Employee(MealSignUpRequest(
          date: fromDate.value.toIso8601String(),
          employeeIds: employees.value.data
              .where((element) => element.isChoose)
              .map((e) => e.id)
              .toList(),
          mealType: chooseMealTypeCl.text == "Cơm mặn" ? 1 : 0,
          shiftType: chooseShift.value.id));
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Đăng kí thành công"));
      getOverviewMeal(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      Navigator.pop(context);
    } finally {}
  }

  Future<void> getOverviewMeal(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      getMealOverviewLoading.value = true;
      mealOverView.value = await _mealRepository.getMealOverview(MealRequest(
          date: currentDate.value.toIso8601String(),
          scheduleGroupId: currentScheduleGroup.value.id));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      getMealOverviewLoading.value = false;
    }
  }

  Future<void> getScheduleGroup(BuildContext context) async {
    try {
      // showLoadingDialog(context);
      scheduleGroup.value = await _mealRepository.getScheduleGroup();
      currentScheduleGroup.value = scheduleGroup.first;
      getOverviewMeal(context);
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
      var e = await _mealRepository.getEmployees(GetEmployeeRequest(
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
      var e = await _mealRepository.getEmployees(
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
