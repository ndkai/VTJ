// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vkhealth/app/modules/account/bindings/account_binding.dart';
import 'package:vkhealth/app/modules/account/views/account_view.dart';
import 'package:vkhealth/app/modules/account/views/password_setting_view.dart';
import 'package:vkhealth/app/modules/account/views/user_info_view.dart';
import 'package:vkhealth/app/modules/attendance/bindings/attendance_binding.dart';
import 'package:vkhealth/app/modules/attendance/views/attendance_view.dart';
import 'package:vkhealth/app/modules/auth/bindings/auth_binding.dart';
import 'package:vkhealth/app/modules/auth/views/components/otp_view.dart';
import 'package:vkhealth/app/modules/auth/views/forget_pass_view.dart';
import 'package:vkhealth/app/modules/meal/bindings/meal_binding.dart';
import 'package:vkhealth/app/modules/meal/views/meal_manage_view.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/attendance/views/employee-attendance-view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/meal/views/meal_statistic_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/timeoff/bindings/timeoff_binding.dart';
import '../modules/timeoff/views/admin/admin_timeoff_manage_view.dart';
import 'app_routes.dart';

class Theme1AppPages{
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(name: Routes.ROOT, page: () => const RootView(), binding: RootBinding(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routes.LOGIN, page: () => const LoginView(), binding: AuthBinding()),
    // GetPage(name: Routes.TIMEOFF, page: () => const UserTimeOffViewManager(), binding: TimeoffBinding()),
    GetPage(name: Routes.TIMEOFF, page: () => const AdminTimeOffViewManager(), binding: TimeoffBinding()),
    GetPage(name: Routes.CONFIRM_OTP, page: () => const OtpView(), binding: AuthBinding()),
    GetPage(name: Routes.REGISTER, page: () => const RegisterView(), binding: AuthBinding()),
    GetPage(name: Routes.ACCOUNT, page: () => const AccountView(), binding: AccountBinding()),
    GetPage(name: Routes.USER_INFOR, page: () => const UserInfoView(), binding: AccountBinding()),
    GetPage(name: Routes.PASSWORD_SETTING, page: () => const PasswordSettingView(), binding: AccountBinding()),
    GetPage(name: Routes.FORGET_PASS, page: () => const ForgetPassView(), binding: AccountBinding()),
    GetPage(name: Routes.MEAL_MANAGE, page: () => const MealManagePage(), binding: MealBinding()),
    GetPage(name: Routes.ATTENDANCE, page: () => const AttendanceView(), binding: AttendanceBinding()),
    GetPage(name: Routes.E_ATTENDANCE, page: () => const EmployeeAttendanceView(), binding: AttendanceBinding()),

  ];
}