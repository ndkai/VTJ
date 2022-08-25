// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:vkhealth/app/models/request_models/attendance/attendance_resquest.dart';
import 'package:vkhealth/app/models/request_models/attendance/manuala_reuquest.dart';
import 'package:vkhealth/app/models/request_models/auth/login_request.dart';
import 'package:vkhealth/app/models/request_models/auth/register_request.dart';
import 'package:vkhealth/app/models/request_models/meal/batch_for_anonymous.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_statistic.dart';
import 'package:vkhealth/app/models/request_models/meal/small_unit_swagger.dart';
import 'package:vkhealth/app/models/request_models/timeoff/time_off_request.dart';
import 'package:vkhealth/app/models/request_models/timeoff/time_off_type.dart';
import 'package:vkhealth/app/models/request_models/user/password_change.dart';
import 'package:vkhealth/app/models/response_models/attendance/attendance_detailed.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';
import 'package:vkhealth/app/models/response_models/booking/interval_for_date.dart';
import 'package:vkhealth/app/models/response_models/booking/service_model.dart';
import 'package:vkhealth/app/models/response_models/timeoff/responses/employee_timeoff.dart'
    as timeoff;
import 'package:vkhealth/app/models/response_models/user/employee_swagger.dart';
import 'package:vkhealth/app/models/response_models/user/profile.dart';
import 'package:vkhealth/app/providers/api_provider.dart';
import 'package:vkhealth/app/services/api_service_impl.dart';

import '../../common/api_constant.dart';
import '../models/request_models/attendance/all_schedule_request.dart';
import '../models/request_models/attendance/create_shift_request.dart';
import '../models/request_models/attendance/over_time_request.dart';
import '../models/request_models/booking/bookinghis_query.dart';
import '../models/request_models/booking/save_image_file.dart';
import '../models/request_models/employees/employees_requets.dart';
import '../models/request_models/meal/meal_batch_request.dart';
import '../models/request_models/meal/meal_request.dart';
import '../models/request_models/meal/meal_sign_up-reuquest.dart';
import '../models/response_models/attendance/schedule_swagger.dart';
import '../models/response_models/attendance/shift_response.dart';
import '../models/response_models/booking/booking-history.dart';
import '../models/response_models/booking/date_for_service.dart';
import '../models/response_models/meal/meal_overview.dart';
import '../models/response_models/user/employeeData.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'api_provider.dart';

class DotnetProvider extends GetxService with ApiProvider {
  ApiClient _httpClient;

  DotnetProvider() {
    baseUrl = globalService.global.value.apiUrl;
    _httpClient = ApiClient(dio.Dio());
    final authService = Get.find<AuthService>();
    _httpClient.setupToken(authService.apiToken);
  }

  Future<DotnetProvider> init() async {
    return this;
  }

  void forceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {}
  }

  void unForceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {}
  }

  Future<User> login(LoginRequest request) async {
    dio.Response response;
    try {
      var body = jsonEncode(
          {"username": request.username, "password": request.password});
      response =
          await _httpClient.dio.request("${ApiConstants.mainApi}/Users/Login",
              options: Options(
                method: "POST",
              ),
              data: body);
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      } else {
        throw Exception(e);
      }
    }
    print('provider - login ${response.data}');
    if (response.statusCode == 200) {
      User user = UserSwagger.fromJson(response.data).data;
      user.auth = true;
      user.dateExpired = DateTime.now()
          .add(Duration(milliseconds: user.expiresIn))
          .toIso8601String();
      _httpClient.setupToken(user.token);
      return user;
    } else {
      throw Exception(response.data);
    }
  }

  Future<bool> signup(RegisterRequest request) async {
    dio.Response response;
    try {
      // var body = jsonEncode({
      //   "username": request.username,
      //   "password": request.password
      // });
      response = await _httpClient.dio.post(
        "${ApiConstants.userAPi}/Users",
        data: request.toJson(),
      );
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception("Số điện thoại đã tồn tại trên hệ thống");
      }
      throw Exception(e);
    }
    print('provider - signup ${response.data}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<ServiceModel>> getServices(String id) async {
    dio.Response response;
    Map<String, dynamic> queryParams = <String, dynamic>{"id": id};
    try {
      response = await _httpClient.dio.get<List<dynamic>>(
        "${ApiConstants.scheduleAPi}/Services",
        queryParameters: queryParams,
      );
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getServices ${response.data}');
    if (response.statusCode == 200) {
      List<dynamic> value = response.data.map<ServiceModel>((dynamic i) {
        return ServiceModel.fromJson(i);
      }).toList();

      return value;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<DateForService>> getDatesForService(
      String unitId, String serviceId) async {
    dio.Response response;
    unitId = "ad365e31-3e94-4d3e-4256-08d9e32f890c";
    // serviceId = "26288bbd-6ddc-42c2-8555-08da0cad069e";
    Map<String, dynamic> queryParams = <String, dynamic>{
      "serviceId": serviceId,
      "unitId": unitId,
    };
    try {
      response = await _httpClient.dio.get<List<dynamic>>(
        "${ApiConstants.scheduleAPi}/WorkingCalendars/GetDaysByUnitAndService",
        queryParameters: queryParams,
      );
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getDatesForService ${response.data}');
    if (response.statusCode == 200) {
      List<dynamic> value = response.data.map<DateForService>((dynamic i) {
        return DateForService.fromJson(i);
      }).toList();
      print("sddd ${value.length}");

      return value;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<IntervalForDate>> getIntervalForDate(String dateId) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post<List<dynamic>>(
          "${ApiConstants.scheduleAPi}/WorkingCalendars/GetIntervals",
          data: "[\"$dateId\"]");
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    if (response.statusCode == 200) {
      List<dynamic> value = response.data.map<IntervalForDate>((dynamic i) {
        return IntervalForDate.fromJson(i);
      }).toList();

      return value;
    } else {
      throw Exception(response.data);
    }
  }

  Future<Profile> getUserProfile() async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.scheduleAPi}/Profiles",
        // queryParameters: queryParams
      );
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getUserProfile ${response.data}');
    if (response.statusCode == 200) {
      return Profile.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> saveImageFile(SaveImageRequest request) async {
    dio.Response response;
    try {
      dio.FormData formData = dio.FormData.fromMap(request.toJson());
      dio.MultipartFile file = dio.MultipartFile.fromBytes(
          request.file.readAsBytesSync(),
          filename: DateTime.now().millisecondsSinceEpoch.toString(),
          contentType: MediaType("image", "jpeg"));
      List<MapEntry<String, dio.MultipartFile>> mapEntries =
          <MapEntry<String, dio.MultipartFile>>[];
      mapEntries.add(MapEntry(
        "FormData",
        file,
      ));
      formData.files.addAll(mapEntries);
      response = await _httpClient.dio.post(
        "${ApiConstants.bookingAPi}/Examinations/SaveFileImages",
        data: formData,
      );
    } catch (e) {
      if (e is dio.DioError) {
        print("saveImageFile ${e.response.toString()}");
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - saveImageFile ${response.data}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> deleteBooking(String id) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.delete(
        "${ApiConstants.bookingAPi}/Examinations",
        data: jsonEncode({"id": id, "status": 3}),
      );
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - deleteBooking ${response.data}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<BookingHistory> getBookingHistory(BookingHisQuery query) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
          "${ApiConstants.bookingAPi}/Examinations",
          queryParameters: query.toJson());
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getBookingHistory ${response.data}');
    if (response.statusCode == 200) {
      return BookingHistory.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> changePassword(PasswordChange passwordChange) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.put(
          "${ApiConstants.mainApi}/Users/ChangePassword",
          data: passwordChange.toJson());
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - changePassword ${response.data}');
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.data);
    }
  }

  Future<EmployeeUserData> getEmployeeInfo(String code) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/Employees/GetByCode/$code",
      );
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - getEmployeeInfo ${response.data}');
    if (response.statusCode == 200) {
      return EmployeeUserData.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> updateUserProfile(Profile profile) async {
    dio.Response response;
    try {
      response = await _httpClient.dio
          .put("${ApiConstants.scheduleAPi}/Profiles", data: profile.toJson());
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - updateUserProfile ${response.data}');
    if (response.statusCode == 200) {
      return;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> generateOtp(String phoneNumber) async {
    dio.Response response;
    try {
      response = await _httpClient.dio
          .post("${ApiConstants.userAPi}/Users/ResetPassword/GenerateOTP",
              data: jsonEncode({
                "phoneNumber": phoneNumber,
              }));
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.response.toString());
      }
      throw Exception(e);
    }
    print('provider - generateOtp ${response.data}');
    if (response.statusCode == 200) {
      return;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> confirmOtp(String phoneNumber, String otp) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.userAPi}/Users/ResetPassword/ConfirmOTP",
          data: jsonEncode({"phoneNumber": phoneNumber, "otp": otp}));
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception("OTP không chính xác");
      }
      throw Exception(e);
    }
    print('provider - generateOtp ${response.data}');
    _httpClient.setupToken(response.data['access_token']);
    if (response.statusCode == 200) {
      return;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> resetPass(String newPass) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.userAPi}/Users/ResetPassword",
          data: jsonEncode({"newPassword": newPass}));
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception(e.toString());
      }
      throw Exception(e);
    }
    print('provider - generateOtp ${response.data}');
    if (response.statusCode == 200) {
      return;
      // return UserInfoSwagger.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<timeoff.EmployeeTimeOff>> getEmployeeTimeOff(
      String fromDate, String toDate, int index,
      {String code = ""}) async {
    dio.Response response;
    try {
      Map<String, dynamic> queryParams = <String, dynamic>{
        "fromDate": fromDate,
        "toDate": toDate,
        "pageIndex": index,
        "pageSize": 10000,
        "code": code,
      };
      response = await _httpClient.dio.get("${ApiConstants.mainApi}/TimeOffs",
          queryParameters: queryParams);
    } catch (e) {
      if (e is dio.DioError) {
        throw Exception("Lấy thông tin thất bại");
      }
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - getEmployeeTimeOff ${response.data}');
    if (response.statusCode == 200) {
      return timeoff.EmployeeTimeOffSwagger.fromJson(
              response.data as Map<String, dynamic>)
          .data;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<EmployeeAttendance>> getEmployeeAttendance(String fromDate,
      String toDate, String scheduleGroupId, String keyword) async {
    dio.Response response;
    try {
      Map<String, dynamic> queryParams = <String, dynamic>{
        "fromDate": fromDate,
        "toDate": toDate,
        "groupBy": 1,
        "scheduleGroupId": scheduleGroupId,
        "pageSize": 10000,
        "pageIndex": 0,
        "keyword": keyword
      };
      response = await _httpClient.dio.get(
          "${ApiConstants.mainApi}/Attendances",
          queryParameters: queryParams);
    } catch (e) {
      print('provider - getEmployeeAttendance $e');
      if (e is dio.DioError) {
        throw Exception("Lấy thông tin thất bại");
      }
      throw Exception("Lấy thông tin thất bại");
    }
    if (response.statusCode == 200) {
      return EmployeeAttendanceSwagger.fromJson(
              response.data as Map<String, dynamic>)
          .data;
    } else {
      throw Exception(response.data);
    }
  }

  Future<List<ScheduleGroup>> getScheduleGroup() async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/ScheduleGroups",
      );
    } catch (e) {
      print('provider - getScheduleGroup $e');
      // if(e is dio.DioError){
      //   throw Exception("Lấy thông tin thất bại");
      // }
      throw Exception("Lấy thông tin thất bại");
    }
    if (response.statusCode == 200) {
      return ScheduleGroupSwagger.fromJson(
              response.data as Map<String, dynamic>)
          .data;
    } else {
      throw Exception(response.data);
    }
  }

  Future<bool> postTimeOff(PostTimeOffRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio
          .post("${ApiConstants.mainApi}/TimeOffs", data: request.toJson());
    } catch (e) {
      print('provider - postTimeOff $e');
      throw Exception("Tạo đơn không thành công");
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data);
    }
  }

  Future<EmployeeSwagger> getEmployee(GetEmployeeRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
          "${ApiConstants.mainApi}/Employees?isEmployeeAdditional=false&pageIndex=0&pageSize=2147483647",
          queryParameters: request.toJson());
    } catch (e) {
      print('provider - getEmployees $e');
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - getEmployees ${response.data}');
    if (response.statusCode == 200) {
      return EmployeeSwagger.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<AttendanceDetailSwagger> getDetailedAttendance(
      AttendanceRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/Attendances/History/${request.id}?fromDate=${request.fromDate}&toDate=${request.toDate}&pageIndex=0&pageSize=129129129",
        // queryParameters: request.toJson()
      );
    } catch (e) {
      log('provider - getDetailedAttendance $e');
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - getDetailedAttendance ${response.data}');
    if (response.statusCode == 200) {
      return AttendanceDetailSwagger.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<void> attendanceManual(EmployeeManualRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.mainApi}/Attendances/AttendanceByManual",
          data: request.toJson());
    } catch (e) {
      print('provider - attendanceManual $e');
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - attendanceManual ${response.data}');
  }

  Future<void> overtimeSignUp(OverTimeRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.mainApi}/Schedules/${request.id}/AddOvertime",
          data: request.toJson());
    } catch (e) {
      print('provider - overtimeSignUp $e');
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - overtimeSignUp ${response.data}');
  }

  Future<void> deleteSchedule(String id) async {
    dio.Response response;
    try {
      print("lll ${ApiConstants.mainApi}/Schedules/$id");
      response = await _httpClient.dio.delete(
        "${ApiConstants.mainApi}/Schedules/$id",
      );
    } catch (e) {
      print('provider - deleteSchedule er $e');
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - deleteSchedule ${response.data}');
  }

  Future<void> createSchedule(CreateScheduleRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio
          .post("${ApiConstants.mainApi}/Schedules", data: request.toJson());
    } catch (e) {
      print('provider - createSchedule er $e');
      throw Exception("Lấy thông tin thất bại");
    }
    print('provider - createSchedule ${response.data}');
  }

  Future<ShiftResponse> getShift() async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/Shifts?pageIndex=0&pageSize=2147483647",
      );
      print('provider - getShift ${response.data}');
      if (response.statusCode == 200) {
        return ShiftResponse.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      print('provider - getShift er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<void> overallCreateSchedule(OverallScheduleRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.mainApi}/Schedules/Batch",
          data: request.toJson());
      print('provider - overallCreateSchedule ${response.data}');
    } catch (e) {
      print('provider - overallCreateSchedule er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<void> overTimeBatch(OverallScheduleRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.mainApi}/Schedules/AddOvertimeBatch",
          data: request.toJson());
      print('provider - overTimeBatch ${response.data}');
    } catch (e) {
      print('provider - overTimeBatch er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<TimeOffType> getTimeOffType() async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/TimeOffTypes",
      );
      print('provider - getTimeOffType ${response.data}');
      return TimeOffType.fromJson(response.data);
    } catch (e) {
      print('provider - getTimeOffType er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<MealOverView> getMealOverview(MealRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
          "${ApiConstants.mainApi}/Meals/GetByEmployee?hasUnitChild=true&pageIndex=0&pageSize=101111",
          queryParameters: request.toJson());
      print('provider - getMealOverview ${response.data}');
      return MealOverView.fromJson(response.data);
    } catch (e) {
      print('provider - getMealOverview er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<void> postMeal4Employee(MealSignUpRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio
          .post("${ApiConstants.mainApi}/Meals/Batch", data: request.toJson());
      print('provider - mealBatchpostMeal4Employee ${response.data}');
    } catch (e) {
      print('provider - mealBatchpostMeal4Employee er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<void> confirmMeal(MealBatchRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio
          .post("${ApiConstants.mainApi}/Meals/Batch", data: request.toJson());
      print('provider - confirmMeal ${response.data}');
    } catch (e) {
      print('provider - confirmMeal er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<MealStatistic> getMealStatistic() async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/Statistics/Meal/Unit?unitType=0&hasChildUnit=true&pageIndex=0&pageSize=10",
      );
      print('provider - getMealStatistic ${response.data}');
      return MealStatistic.fromJson(response.data);
    } catch (e) {
      print('provider - getMealStatistic er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<SmallUnitSwagger> getSmallUnit(int id) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.get(
        "${ApiConstants.mainApi}/Units?type=$id&pageIndex=0&pageSize=2147483647",
      );
      print('provider - getSmallUnit ${response.data}');
      return SmallUnitSwagger.fromJson(response.data);
    } catch (e) {
      print('provider - getSmallUnit er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }

  Future<void> batchForAnonymous(BatchForAnonymousRequest request) async {
    dio.Response response;
    try {
      response = await _httpClient.dio.post(
          "${ApiConstants.mainApi}/Meals/BatchForAnonymous",
          data: request.toJson());
      print('provider - batchForAnonymous ${response.data}');
    } catch (e) {
      print('provider - batchForAnonymous er $e');
      throw Exception("Lấy thông tin thất bại");
    }
  }
}
