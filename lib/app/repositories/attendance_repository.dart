
import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/attendance/attendance_resquest.dart';
import 'package:vkhealth/app/models/request_models/attendance/create_shift_request.dart';
import 'package:vkhealth/app/models/request_models/employees/employees_requets.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';
import 'package:vkhealth/app/models/response_models/user/employee_swagger.dart';
import 'package:vkhealth/app/providers/dotnet_provider.dart';

import '../models/request_models/attendance/all_schedule_request.dart';
import '../models/request_models/attendance/manuala_reuquest.dart';
import '../models/request_models/attendance/over_time_request.dart';
import '../models/response_models/attendance/attendance_detailed.dart';
import '../models/response_models/attendance/schedule_swagger.dart';
import '../models/response_models/attendance/shift_response.dart';

class AttendanceRepository {
  DotnetProvider _dotnetProvider;

  AttendanceRepository(){
    _dotnetProvider = Get.find<DotnetProvider>();
  }

  Future<List<EmployeeAttendance>> getEmployeeAttendance(String fromDate, String toDate,String scheduleGroupId, String keyword){
    return _dotnetProvider.getEmployeeAttendance(fromDate, toDate, scheduleGroupId, keyword);
  }

  Future<List<ScheduleGroup>> getScheduleGroup(){
    return _dotnetProvider.getScheduleGroup();
  }

  Future<EmployeeSwagger> getEmployees(GetEmployeeRequest request){
    return _dotnetProvider.getEmployee(request);
  }

  Future<AttendanceDetailSwagger> getAttendanceDetailed(AttendanceRequest request){
    return _dotnetProvider.getDetailedAttendance(request);
  }

  Future<void> attendanceManual(EmployeeManualRequest request){
    return _dotnetProvider.attendanceManual(request);
  }

  Future<void> overtimeSignUp(OverTimeRequest request){
    return _dotnetProvider.overtimeSignUp(request);
  }

  Future<void> deleteSchedule(String id){
    return _dotnetProvider.deleteSchedule(id);
  }

  Future<void> createSchedule(CreateScheduleRequest request){
    return _dotnetProvider.createSchedule(request);
  }

  Future<ShiftResponse> getShift(){
    return _dotnetProvider.getShift();
  }

  Future<void> overallCreateSchedule(OverallScheduleRequest request){
    return _dotnetProvider.overallCreateSchedule(request);
  }

  Future<void> overTimeBatch(OverallScheduleRequest request){
    return _dotnetProvider.overTimeBatch(request);
  }
}
