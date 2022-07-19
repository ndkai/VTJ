import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/block_button_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/success_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../global_widgets/text_field_widget.dart';
import '../controllers/timeoff_controller.dart';

class HaveSalaryDoView extends GetView<TimeOffController> {
  const HaveSalaryDoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Tạo nghỉ phép",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text("Thông tin chung".tr, style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold)).marginOnly(left: 10),
          TextFieldWidget(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
            labelText: "Mã nhân viên".tr,
            hintText: "",
            isEdit: false,
            labelStyle: const TextStyle(
                color: Colors.black ,
                fontSize: 18
            ),
            initialValue: controller.currentUser.value.userInfo.id,
          ),
          TextFieldWidget(
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
            initialValue: controller.currentUser.value.userInfo.fullname,
          ),
          Text("Thông tin chung".tr, style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold)).marginOnly(left: 10),
          TextFieldWidget(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
            labelText: "Loại nghỉ phép".tr,
            hintText: "",
            isEdit: false,
            labelStyle: const TextStyle(
                color: Colors.black ,
                fontSize: 18
            ),
            initialValue: "Nghĩ phép không lương",
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 00, bottom: 10),
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Get.theme.focusColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
                ],
                border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
            child: Obx(
                (){
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Từ ngày", style: TextStyle(color: Colors.black87, fontSize: 18),),
                          TextButton(child: Text(Helper.getVietnameseTime(controller.fromDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
                            DateTime now = DateTime.now();
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: now.subtract(const Duration(days: 10)),
                                maxTime: now.add(const Duration(days: 365)),
                                onChanged: (date) {}, onConfirm: (date) {
                                  controller.fromDate.value = date;
                                }, currentTime: DateTime.now(), locale: LocaleType.vi);
                          },)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Đến ngày", style: TextStyle(color: Colors.black87, fontSize: 18),),
                          TextButton(child: Text(Helper.getVietnameseTime(controller.toDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
                            DateTime now = DateTime.now();
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: now.subtract(const Duration(days: 10)),
                                maxTime: now.add(const Duration(days: 365)),
                                onChanged: (date) {}, onConfirm: (date) {
                              controller.toDate.value = date;
                                }, currentTime: DateTime.now(), locale: LocaleType.vi);
                          },)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tổng ngày", style: TextStyle(color: Colors.black87, fontSize: 18),),
                          Text("${controller.toDate.value.difference(controller.fromDate.value).inDays.toString()}       ", style: const TextStyle(color: Colors.blue, fontSize: 18),),
                        ],
                      ),
                    ],
                  );
                }
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth,
            child: BlockButtonWidget(
              onPressed: () {
                showAppSuccesDialog(context, title: "Xác nhận tạo đơn nghỉ phép thành công");
              },
              color: Get.theme.colorScheme.secondary,
              text: Text(
                "Gửi Đề Xuất",
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: Get.theme.primaryColor, fontSize: 18)),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 10).marginOnly(top: 20),
          )
        ],
      ),
    );
  }
}
