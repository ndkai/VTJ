import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/account/controllers/account_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';

import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../global_widgets/text_field_widget.dart';

class UserInfoView extends GetView<AccountController> {
  const UserInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BasePage(
      title: "Thông tin cá nhân",
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.9,
        child: Obx(() {
          return Form(
            key: controller.infoFormKey,
            child: ListView(
              primary: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Mã nhân viên".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: controller.employeeInfo.value.data.first.code,
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Họ và tên".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: controller.employeeInfo.value.data.first.name,
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Giởi tính".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: controller.employeeInfo.value.data.first.gender == 1 ? "Nam" : "Nữ",
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Ngày sinh".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: Helper.getVietnameseTime(controller.employeeInfo.value.data.first.dateOfBirth),
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Số điện thoại".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: controller.employeeInfo.value.data.first.phoneNumber,
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Chi nhánh".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: "",
                ),
                TextFieldWidget(
                  isEdit: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  labelText: "Ngày vào công ty".tr,
                  hintText: "",
                  labelStyle: const TextStyle(
                      color: Colors.black ,
                      fontSize: 18
                  ),
                  initialValue: Helper.getVietnameseTime(controller.employeeInfo.value.data.first.dateJoined),
                ),
            ]),
          );
        }),
      ),
    );
  }

  Widget horiFunc(String icon, String title, {Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.01,
                ),
                Image.asset(icon,
                    height: SizeConfig.screenWidth * 0.11,
                    width: SizeConfig.screenWidth * 0.09),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.04,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.screenWidth * 0.045,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: SizeConfig.screenWidth * 0.04,
              color: Colors.black.withOpacity(0.7),
            )
          ],
        ),
      ),
    );
  }
}
