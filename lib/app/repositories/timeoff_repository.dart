
import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/timeoff/time_off_request.dart';
import 'package:vkhealth/app/models/response_models/timeoff/responses/employee_timeoff.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/request_models/employees/employees_requets.dart';
import '../models/request_models/timeoff/time_off_type.dart';
import '../models/response_models/user/employee_swagger.dart';


class TimeOffRepository {
  DotnetProvider _dotnetProvider;

  TimeOffRepository(){
    _dotnetProvider = Get.find<DotnetProvider>();
  }

  Future<List<EmployeeTimeOff>> getEmployeeTimeOff(String fromDate, String toDate, int index, {String code = ""}){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getEmployeeTimeOff(fromDate, toDate, index, code: code);
  }

  Future<bool> postTimeOff(PostTimeOffRequest request){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.postTimeOff(request);
  }

  Future<EmployeeSwagger> getEmployees(GetEmployeeRequest request){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getEmployee(request);
  }
  Future<TimeOffType> getTimeOffType(){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getTimeOffType();
  }

}
