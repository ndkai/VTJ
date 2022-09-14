// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vkhealth/app/models/request_models/auth/login_request.dart';
import 'package:vkhealth/app/repositories/user_repository.dart';
import 'package:vkhealth/common/helper.dart';

import '../../../../common/ui.dart';
import '../../../models/provice.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/setting_service.dart';
import '../../global_widgets/dialog/loading_dialog.dart';

class AuthController extends GetxController {
  final Rx<LoginRequest> loginRequest = LoginRequest().obs;
  final authService = Get.find<AuthService>();
  final settingService = Get.find<SettingsService>();
  final Rx<User> currentUser = Get.find<AuthService>().user;
  final loading = false.obs;
  final hidePassword = true.obs;
  final fhidePassword = true.obs;
  final fchidePassword = true.obs;
  final phoneNumber = "".obs;
  final otp = "".obs;
  final newPass = "".obs;
  final remember = true.obs;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> forgotPasswordFormKey;
  UserRepository _userRepository;
  GetStorage box;

  AuthController() {
    _userRepository = UserRepository();
    box = GetStorage();
    try {
      loginRequest.value.username = box.read("LOGIN-USERNAME");
    } catch (e) {}
  }

  Future<void> generateOTP(BuildContext context) async {
    forgotPasswordFormKey.currentState.save();
    if (forgotPasswordFormKey.currentState.validate()) {
      try {
        showLoadingDialog(context);
        await _userRepository.generateOtp(phoneNumber.value);
        Navigator.pop(context);
        Get.toNamed(Routes.CONFIRM_OTP);
      } catch (e) {
        Navigator.pop(context);
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    }
  }

  Future<void> confirmOtp(BuildContext context) async {
    try {
      await _userRepository.confirmOtp(phoneNumber.value, otp.value);
      resetPass(context);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> resetPass(BuildContext context) async {
    try {
      showLoadingDialog(context);
      await _userRepository.resetPass(newPass.value);
      Navigator.of(context).pop();
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Đổi mật khẩu thành công"));
      Get.toNamed(Routes.LOGIN);
    } catch (e) {
      Navigator.of(context).pop();
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: e.toString().replaceAll("Exception: ", "")));
    } finally {}
  }

  void login(BuildContext context) async {
    Get.focusScope.unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      loading.value = true;
      try {
        if (remember.value) {
          box.write("LOGIN-USERNAME", loginRequest.value.username);
        }
        User user = await _userRepository.login(loginRequest.value);
        currentUser.value = user;
        currentUser.value.dateExpired = user.dateExpired;
        await authService.changeUser(user);
        authService.user.value.auth = true;
        await Get.toNamed(Routes.ROOT, arguments: 0);
      } catch (e) {
        Get.showSnackbar(
            Ui.RemindSnackBar(message: "Tài khoản hoặc mật khẩu không đúng"));
      } finally {
        loading.value = false;
      }
    }
  }

  Future<void> goToRegisterPage(BuildContext context) async {
    Provinces provinces = await Helper().getProvinceFormJson(context);
    Get.toNamed(Routes.REGISTER, arguments: provinces);
  }
}
