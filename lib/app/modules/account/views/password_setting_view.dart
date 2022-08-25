import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/account_controller.dart';

class PasswordSettingView extends GetView<AccountController> {
  const PasswordSettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.formKey = GlobalKey<FormState>();
    return BasePage(
      title: "Cài đặt mật khẩu",
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.89,
        child: Obx(() {
          return Form(
              key: controller.formKey,
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    primary: true,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldWidget(
                        labelText: "Mật khẩu Hiện Tại".tr,
                        hintText: "••••••••••••",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        initialValue: "",
                        onSaved: (s) {
                          controller.oldPass.value = s;
                        },
                        validator: (input) => input.length < 5
                            ? "Mật khẩu lớn hơn 5 kí tự"
                            : null,
                        obscureText: controller.hidePassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(controller.hidePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                      ).marginSymmetric(horizontal: 10),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldWidget(
                        labelText: "Mật khẩu Mới".tr,
                        hintText: "••••••••••••",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        initialValue: "",
                        onSaved: (s) {
                          controller.newPass.value = s;
                        },
                        validator: (input) => input.length < 5
                            ? "Mật khẩu lớn hơn 5 kí tự"
                            : null,
                        obscureText: controller.hideNPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.hideNPassword.value =
                                !controller.hideNPassword.value;
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(controller.hideNPassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                      ).marginSymmetric(horizontal: 10),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldWidget(
                        labelText: "Nhập Lại Mật Khẩu Mới".tr,
                        hintText: "••••••••••••",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        initialValue: "",
                        onSaved: (s) {
                          controller.cnPass.value = s;
                        },
                        validator: (input) => input != controller.newPass.value
                            ? "Không trùng với mật khẩu mới"
                            : null,
                        obscureText: controller.hideCPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.hideCPassword.value =
                                !controller.hideCPassword.value;
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(controller.hideCPassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                      ).marginSymmetric(horizontal: 10),
                      const SizedBox(
                        height: 20,
                      ),
                      BlockButtonWidget(
                        onPressed: () {
                          controller.changePass(context);
                        },
                        color: Get.theme.colorScheme.secondary,
                        text: Text(
                          "Đổi mật khẩu",
                          style: Get.textTheme.headline6
                              .merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingSymmetric(vertical: 10, horizontal: 30),
                    ],
                  )));
        }),
      ),
    );
  }
}
