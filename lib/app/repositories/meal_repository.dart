
import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_sign_up-reuquest.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_statistic.dart';
import 'package:vkhealth/app/models/response_models/meal/meal_overview.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/request_models/employees/employees_requets.dart';
import '../models/request_models/meal/meal_batch_request.dart';
import '../models/request_models/meal/meal_request.dart';
import '../models/response_models/attendance/schedule_swagger.dart';
import '../models/response_models/user/employee_swagger.dart';

class MealRepository {
  DotnetProvider _dotnetProvider;

  MealRepository(){
    _dotnetProvider = Get.find<DotnetProvider>();
  }

  Future<EmployeeSwagger> getEmployees(GetEmployeeRequest request){
    return _dotnetProvider.getEmployee(request);
  }

  Future<List<ScheduleGroup>> getScheduleGroup(){
    return _dotnetProvider.getScheduleGroup();
  }

  Future<MealOverView> getMealOverview(MealRequest request){
    return _dotnetProvider.getMealOverview(request);
  }

  Future<void> postMeal4Employee(MealSignUpRequest request){
    return _dotnetProvider.postMeal4Employee(request);
  }

  Future<void> confirmMeal(MealBatchRequest request){
    return _dotnetProvider.confirmMeal(request);
  }

  Future<MealStatistic> getMealStatistic(){
    return _dotnetProvider.getMealStatistic();
  }
}
