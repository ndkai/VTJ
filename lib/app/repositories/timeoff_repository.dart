
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/timeoff/responses/employee_timeoff.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';


class TimeOffRepository {
  DotnetProvider _dotnetProvider;

  TimeOffRepository(){
    _dotnetProvider = Get.find<DotnetProvider>();
  }

  Future<List<EmployeeTimeOff>> getEmployeeTimeOff(String fromDate, String toDate, int index){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getEmployeeTimeOff(fromDate, toDate, index);
  }
}
