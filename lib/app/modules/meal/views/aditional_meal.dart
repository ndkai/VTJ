import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/attendance/views/component/data_item.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/choose_meal_shift/choose_shift_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/show_small_unit/show_small_unit.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';

import '../../../../common/helper.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/dialog/choose_app_unit/choose_app_unit_dialog.dart';
import '../../global_widgets/dialog/choose_meal_type/choose_shift_dialog.dart';
import '../../global_widgets/text_field_widget.dart';

class AdditionalMealView extends GetView<MealController> {
  const AdditionalMealView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getSmallUnit(context, 0);
    return BasePage(
      title: "Tạo Bổ Sung Cơm",
      child: MediaQuery.removeViewPadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Thông tin đăng kí",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(() {
                    return dataItem(
                        "Thời gian",
                        TextButton(
                          child: Text(
                            Helper.getVietnameseTime(
                                controller.fromDate.value.toIso8601String()),
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16),
                          ),
                          onPressed: () {
                            DateTime now = DateTime.now();
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: now.subtract(const Duration(days: 10)),
                                maxTime: now.add(const Duration(days: 365)),
                                onChanged: (date) {}, onConfirm: (date) {
                              controller.fromDate.value = date;
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.vi);
                          },
                        ),
                        showArrow: false);
                  }),
                  TextFieldWidget(
                    keyboardType: TextInputType.none,
                    labelText: "Loại đơn vị".tr,
                    hintText: "",
                    isEdit: false,
                    onTap: () {
                      showAppUnitsDialog(context,
                          // ignore: missing_return
                          (v) {
                        controller.chooseUnitTypeCl.text = v.name;
                        controller.currentUnit.value = v;
                        controller.chooseSmallUnitTypeCl.text = "";
                        controller.getSmallUnit(
                            context, controller.currentUnit.value.id);
                        controller.currentSmallUnit.value = null;
                        controller.smallUnitSwagger.value.data.clear();
                      });
                    },
                    controller: controller.chooseUnitTypeCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    // controller: controller.genderEdt,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    suffixIcon: IconButton(
                      color: Theme.of(context).focusColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.none,
                    labelText: "Đơn vị".tr,
                    hintText: "",
                    isEdit: false,
                    onTap: () {
                      showSmallUnit(
                          context, controller.smallUnitSwagger.value.data,
                          // ignore: missing_return
                          (v) {
                        controller.currentSmallUnit.value = v;
                        controller.chooseSmallUnitTypeCl.text = v.name;
                      });
                    },
                    controller: controller.chooseSmallUnitTypeCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    // controller: controller.genderEdt,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    suffixIcon: IconButton(
                      color: Theme.of(context).focusColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.none,
                    labelText: "Ca làm việc".tr,
                    hintText: "",
                    isEdit: false,
                    onTap: () {
                      showMealShiftDialog(context,
                          // ignore: missing_return
                          (v) {
                        controller.chooseShift.value = v;
                        controller.chooseScheduleCl.text = v.name;
                      });
                    },
                    controller: controller.chooseScheduleCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    // controller: controller.genderEdt,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    suffixIcon: IconButton(
                      color: Theme.of(context).focusColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.none,
                    labelText: "Loại cơm".tr,
                    hintText: "",
                    isEdit: false,
                    onTap: () {
                      showMealTypeDialog(context,
                          // ignore: missing_return
                          (v) {
                        controller.chooseMealTypeCl.text = v;
                      });
                    },
                    controller: controller.chooseMealTypeCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    // controller: controller.genderEdt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    suffixIcon: IconButton(
                      color: Theme.of(context).focusColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    labelText: "Số lượng".tr,
                    hintText: "",
                    isEdit: true,
                    controller: controller.amountCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    // controller: controller.genderEdt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ).marginOnly(top: 20, bottom: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  BlockButtonWidget(
                    borderRadius: 30,
                    onPressed: () async {
                      controller.batchForAnonymous(context);
                    },
                    color: Get.theme.colorScheme.secondary,
                    text: Text(
                      "       Xác nhận       ",
                      style: Get.textTheme.headline6
                          .merge(TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 10)
            ],
          )),
    );
  }
}
