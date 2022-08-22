import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/attendance/views/component/data_item.dart';

import '../../../../common/app_constant.dart';
import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../../../common/ui.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/dialog/loading_dialog.dart';
import '../../global_widgets/pages/base_page.dart';
import '../../global_widgets/search_widget.dart';
import '../controllers/attendance_controller.dart';
import 'component/employee_item.dart';

class CreateOvertimeView extends GetView<AttendanceController> {
  const CreateOvertimeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getEmployees();
    return BasePage(
      title: "Đăng kí tăng ca",
      child: MediaQuery.removePadding(
        context: context,
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Thông tin ca làm việc",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            Column(
              children: [
                Obx(() {
                  return dataItem(
                    "Từ ngày",
                    TextButton(
                      child: Text(
                        Helper.getVietnameseTime(
                            controller.fromDate.value.toIso8601String()),
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () {
                        DateTime now = DateTime.now();
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: now.subtract(const Duration(days: 10)),
                            maxTime: now.add(const Duration(days: 365)),
                            onChanged: (date) {}, onConfirm: (date) {
                          controller.fromDate.value = date;
                        }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                    ),
                  );
                }),
                Obx(() {
                  return dataItem(
                    "Đến ngày",
                    TextButton(
                      child: Text(
                        Helper.getVietnameseTime(
                            controller.toDate.value.toIso8601String()),
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () {
                        DateTime now = DateTime.now();
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: now.subtract(const Duration(days: 10)),
                            maxTime: now.add(const Duration(days: 365)),
                            onChanged: (date) {}, onConfirm: (date) {
                          controller.toDate.value = date;
                        }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const Text(
              "Ngày trong tuần",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            Obx(() {
              return Wrap(
                children: [0, 1, 2, 3, 4, 5, 6]
                    .map((e) => ChoiceChip(
                          selected: controller.dayoffWeek.contains(e),
                          onSelected: (s) {
                            if (controller.dayoffWeek.contains(e)) {
                              controller.dayoffWeek.remove(e);
                            } else {
                              controller.dayoffWeek.add(e);
                            }
                          },
                          selectedColor: Colors.blue.withOpacity(.8),
                          disabledColor: Colors.grey.withOpacity(.1),
                          label: Text(
                            AppConstants.dateInWeek[e],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ).marginAll(3))
                    .toList(),
              );
            }),
            Obx(() {
              return Column(
                children: [
                  dataItem(
                    "Thời gian bắt đầu",
                    TextButton(
                      child: Text(
                        Helper.getHour(controller.startTime.value),
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () async {
                        DateTime dt = await DatePicker.showTimePicker(context,
                            showSecondsColumn: false, locale: LocaleType.vi);
                        if (dt != null) {
                          controller.startTime.value =
                              TimeOfDay(hour: dt.hour, minute: dt.minute);
                        }
                      },
                    ),
                  ),
                  dataItem(
                    "Thời gian kết thúc",
                    TextButton(
                      child: Text(
                        Helper.getHour(controller.endTime.value),
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () async {
                        DateTime dt = await DatePicker.showTimePicker(context,
                            showSecondsColumn: false, locale: LocaleType.vi);
                        if (dt != null) {
                          controller.endTime.value =
                              TimeOfDay(hour: dt.hour, minute: dt.minute);
                        }
                      },
                    ),
                  ),
                  dataItem(
                      "Hệ số lương",
                      DropdownButton<String>(
                          items: [
                            '1.0',
                            '1.3',
                            '1.5',
                            '2.0',
                            '2.15',
                            '2.7',
                            '3.0',
                            '3.9'
                          ].map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            );
                          }).toList(),
                          value: controller.factor.value,
                          hint: Text(
                            controller.factor.value,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          onChanged: (newVal) {
                            controller.factor.value = newVal;
                          }),
                      showArrow: false),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Checkbox(
                            value: controller.mealSignUp.value,
                            onChanged: (v) {
                              controller.mealSignUp.value =
                                  !controller.mealSignUp.value;
                            });
                      }),
                      const Text(
                        "Đăng kí cơm tăng ca",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              );
            }),
            const Text(
              "Danh sách nhân viên",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SearchWidget(
                  title: "Nhập mã, tên để tìm kiếm",
                  height: 40,
                  width: SizeConfig.screenWidth * 0.7,
                  onSummited: (s) {
                    controller.getEmployeesByName(s);
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Ui.parseColor("#ebeced"),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.filter_alt_rounded,
                    size: 15,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Obx(() {
                  return Checkbox(
                    value: controller.chooseAll.value,
                    onChanged: (bool value) {
                      controller.chooseAll.value = !controller.chooseAll.value;
                      for (var i in controller.employees.value.data) {
                        i.isChoose = controller.chooseAll.value;
                      }
                      controller.employees.refresh();
                    },
                  );
                }),
                const Text(
                  "Chọn tất cả",
                  style: TextStyle(fontSize: 16, color: Colors.black),
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
                                controller
                                    .employeeScrollCl.position.maxScrollExtent;
                            if (isEnd) {
                              controller.loadMoreEmployee.value = true;
                              controller.getEmployees();
                            }
                          }
                          return true;
                        },
                        child: ListView(
                          children: controller.employees.value.data
                              .map((e) => EmployeeItem(
                                    employeeData: e,
                                    key: Key(e.code),
                                    onChanged: (e) {
                                      controller.employees.value.data
                                          .firstWhere((element) =>
                                              element.code == e.code)
                                          .isChoose = e.isChoose;
                                      controller.employees.refresh();
                                    },
                                  ))
                              .toList(),
                          controller: controller.employeeScrollCl,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Text(
                    "Đã chọn(${controller.employees.value.data.where((element) => element.isChoose).toList().length})",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  );
                }),
                BlockButtonWidget(
                  onPressed: () async {
                    showLoadingDialog(context);
                    await controller.overallCreateSchedule(context);
                    Navigator.of(context).pop();
                  },
                  color: Get.theme.colorScheme.secondary,
                  text: Text(
                    "Xác nhận",
                    style: Get.textTheme.headline6
                        .merge(TextStyle(color: Get.theme.primaryColor)),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10)
          ],
        ),
        removeTop: true,
      ),
    );
  }
}
