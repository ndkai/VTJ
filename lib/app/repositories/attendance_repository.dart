
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';
import 'package:vkhealth/app/models/response_models/timeoff/responses/employee_timeoff.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/response_models/attendance/schedule_swagger.dart';

class AttendanceRepository {
  DotnetProvider _dotnetProvider;

  AttendanceRepository(){
    _dotnetProvider = Get.find<DotnetProvider>();
  }

  Future<List<EmployeeAttendance>> getEmployeeAttendance(String fromDate, String toDate,String scheduleGroupId){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getEmployeeAttendance(fromDate, toDate, scheduleGroupId);
  }

  Future<List<ScheduleGroup>> getScheduleGroup(){
    _dotnetProvider = Get.find<DotnetProvider>();
    return _dotnetProvider.getScheduleGroup();
  }
}
