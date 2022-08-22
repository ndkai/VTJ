// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/buttons/block_button_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/app/modules/global_widgets/search_widget.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../../common/ui.dart';
import '../../../attendance/views/component/employee_item.dart';
import '../../../global_widgets/circular_loading_widget.dart';
import '../../../global_widgets/dialog/choose_timeoff_type/choose_time_off_type.dart';
import '../../../global_widgets/text_field_widget.dart';
import '../../controllers/timeoff_controller.dart';

class AdminHaveSalaryDOView extends GetView<TimeOffController> {
  const AdminHaveSalaryDOView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Tạo nghỉ phép",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("Chọn nhân viên".tr,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
                .marginOnly(left: 10),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 0, left: 10, right: 10),
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 00, bottom: 0),
              decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Get.theme.focusColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                  border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.05))),
              child: Column(
                children: [
                  Row(
                    children: [
                      SearchWidget(
                        title: "Nhập mã, tên để tìm kiếm",
                        height: 40,
                        width: SizeConfig.screenWidth * 0.75,
                        onChanged: (s) {
                          controller.getEmployeesByName(s);
                        },
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.getEmployeeLoading.value) {
                      return const CircularLoadingWidget(
                        height: 50,
                      );
                    }
                    if (controller.employees.value.data == null) {
                      return const Center(
                        child: Text(
                          "Không có thông tin nhân viên",
                          style: TextStyle(color: Colors.black45),
                        ),
                      );
                    }
                    if (controller.employees.value.data.isNotEmpty) {
                      return SizedBox(
                        height: 300,
                        child: Stack(
                          children: [
                            NotificationListener<ScrollEndNotification>(
                              onNotification: (scrollEnd) {
                                final metrics = scrollEnd.metrics;
                                if (metrics.atEdge) {
                                  bool isEnd = metrics.pixels ==
                                      controller.employeeScrollCl.position
                                          .maxScrollExtent;
                                  if (isEnd) {
                                    controller.loadMoreEmployee.value = true;
                                    controller.getEmployees();
                                  }
                                }
                                return true;
                              },
                              child: MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: ListView(
                                  children: controller.employees.value.data
                                      .map((e) => EmployeeItem(
                                            employeeData: e,
                                            key: Key(e.code),
                                            onChanged: (e) {
                                              for (var i in controller
                                                  .employees.value.data) {
                                                if (i.code == e.code) {
                                                  i.isChoose = true;
                                                } else {
                                                  i.isChoose = false;
                                                }
                                              }
                                              controller.employees.refresh();
                                            },
                                          ))
                                      .toList(),
                                  controller: controller.employeeScrollCl,
                                ),
                              ),
                            ),
                            Obx(() {
                              if (controller.loadMoreEmployee.value) {
                                return Container(
                                  height: 300,
                                  width: SizeConfig.screenWidth,
                                  color: Colors.grey.withOpacity(.2),
                                  child: const Center(
                                    child: CircularLoadingWidget(
                                      height: 30,
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            })
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Text("Thông tin chung".tr,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
                .marginOnly(left: 10),
            InkWell(
              onTap: () {
                showTimeOffDialog(context, controller.timeOfType.value.data,
                    (s) {
                  controller.currentTimeOffType.value = s;
                  controller.currentTimeOffTypeCl.text =
                      controller.currentTimeOffType.value.description;
                });
              },
              child: TextFieldWidget(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                labelText: "Loại nghỉ phép".tr,
                initialValue: "Chọn loại nghỉ phép",
                isEdit: false,
                controller: controller.currentTimeOffTypeCl,
                labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 00, bottom: 10),
              decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Get.theme.focusColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                  border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.05))),
              child: Obx(() {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Từ ngày",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
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
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Đến ngày",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                        TextButton(
                          child: Text(
                            Helper.getVietnameseTime(
                                controller.toDate.value.toIso8601String()),
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
                              if (controller.toDate.value
                                          .difference(controller.fromDate.value)
                                          .inDays ==
                                      -1 ||
                                  controller.toDate.value
                                          .difference(controller.fromDate.value)
                                          .inDays ==
                                      0) {
                                controller.toDate.value = date;
                              } else {
                                Get.showSnackbar(Ui.ErrorSnackBar(
                                    message:
                                        "Ngày kết thúc phải lớn hơn ngày bắt đầu"));
                              }
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.vi);
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tổng ngày",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                        Text(
                          "${(controller.toDate.value.difference(controller.fromDate.value).inDays + 1).toString()}       ",
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: BlockButtonWidget(
                onPressed: () {
                  controller.adminPostTimeOff();
                },
                color: Get.theme.colorScheme.secondary,
                text: Text(
                  "Gửi Đề Xuất",
                  style: Get.textTheme.headline6.merge(
                      TextStyle(color: Get.theme.primaryColor, fontSize: 16)),
                ),
              )
                  .paddingSymmetric(vertical: 10, horizontal: 10)
                  .marginOnly(top: 20),
            )
          ],
        ),
      ),
    );
  }
}
