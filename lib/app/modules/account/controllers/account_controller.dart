// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vkhealth/app/models/request_models/user/password_change.dart';
import 'package:vkhealth/app/models/response_models/user/profile.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/loading_dialog.dart';
import 'package:vkhealth/app/repositories/user_repository.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/provice.dart';
import '../../../models/response_models/user/employeeData.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../global_widgets/dialog/district_select/district_select_dialog.dart';
import '../../global_widgets/dialog/province_select/province_select_dialog.dart';
import '../../global_widgets/dialog/ward_select/ward_select_dialog.dart';

class AccountController extends GetxController {
  Province province;
  Districts district;
  final Rx<User> currentUser = Get.find<AuthService>().user;
  var hidePassword = true.obs;
  var hideNPassword = true.obs;
  var hideCPassword = true.obs;
  var profile = Profile().obs;
  var employeeInfo = EmployeeUserData().obs;
  var oldPass = "".obs;
  var newPass = "".obs;
  var cnPass = "".obs;
  GlobalKey<FormState> formKey;
  GlobalKey<FormState> infoFormKey;
  Wards ward;
  GetStorage _box;
  UserRepository _userRepository;
  TextEditingController genderEdt;
  TextEditingController proviceEdt;
  TextEditingController districtEdt;
  TextEditingController wardEdt;
  TextEditingController dobEdt;

  AccountController() {
    _box = GetStorage();
    _userRepository = UserRepository();
  }

  Future<void> getEmployeeInfo(BuildContext context) async {
    try {
      employeeInfo.value = await _userRepository
          .getEmployeeInfo(currentUser.value.userInfo.employee.code);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {}
  }

  Future<void> uploadProfile(BuildContext context) async {
    try {
      infoFormKey.currentState.save();
      showLoadingDialog(context);
      await _userRepository.updateUserProfile(profile.value);
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Cập nhật thành công"));
      Navigator.of(context).pop();
      Get.toNamed(Routes.ACCOUNT);
    } catch (e) {
      Navigator.of(context).pop();
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      // Navigator.of(context).pop();
    }
  }

  Future<void> changePass(BuildContext context) async {
    Get.focusScope.unfocus();
    formKey.currentState.save();
    if (formKey.currentState.validate()) {
      try {
        showLoadingDialog(context);
        await _userRepository.changePass(PasswordChange(
            newPassword: newPass.value, oldPassword: oldPass.value));
        Navigator.of(context).pop();
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "Đổi mật khẩu thành công"));
        logout();
      } catch (e) {
        Navigator.of(context).pop();
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {}
    }
  }

  Future<DateTime> chooseBirthDate(BuildContext context) async {
    Get.focusScope.unfocus();
    DateTime now = DateTime.now();
    DateTime _pickerTime;
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: now,
        onChanged: (date) {}, onConfirm: (date) {
      _pickerTime = date;
      dobEdt.text = Helper.getVietnameseTime(_pickerTime.toIso8601String());
      profile.value.dateOfBirth = _pickerTime.toIso8601String();
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
    return _pickerTime;
  }

  void chooseProvince(Provinces provinces, BuildContext context) {
    showProvinceSelectDialog(context, provinces, (v) {
      province = v;
      proviceEdt.text = province.label;
      profile.value.province = province.label;
      return;
    });
  }

  void chooseDistrict(BuildContext context) {
    if (province == null) {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "Vui lòng chọn Tỉnh/Thành phố"));
      return;
    }
    showDistrictSelectDialog(context, province, (v) {
      district = v;
      districtEdt.text = district.label;
      profile.value.district = district.label;
      return;
    });
  }

  void chooseWard(BuildContext context) {
    if (district == null) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Vui lòng chọn Quận/Huyện"));
      return;
    }
    showWardSelectDialog(context, district, (v) {
      ward = v;
      wardEdt.text = ward.label;
      profile.value.ward = ward.label;
      return;
    });
  }

  Future<void> logout() async {
    final authService = Get.find<AuthService>();
    authService.removeCurrentUser();
    Get.offAllNamed(Routes.LOGIN);
  }
}
