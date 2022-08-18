import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/attendance/views/component/data_item.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/choose_meal_shift/choose_shift_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/app/modules/global_widgets/search_widget.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';
import 'package:vkhealth/common/size_config.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../../common/helper.dart';
import '../../attendance/views/component/employee_item.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/dialog/choose_meal_type/choose_shift_dialog.dart';
import '../../global_widgets/text_field_widget.dart';

class MealSignUpView extends GetView<MealController> {
  const MealSignUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getEmployees();
    return BasePage(
      title: "Đăng kí cơm",
      child: MediaQuery.removeViewPadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Column(
                children: [
                  Obx(() {
                    return dataItem(
                      "Thời gian",
                      TextButton(
                        child: Text(
                          Helper.getVietnameseTime(
                              controller.fromDate.value.toIso8601String()),
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 18),
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
                    );
                  }),
                  TextFieldWidget(
                    keyboardType: TextInputType.none,
                    labelText: "Chọn ca làm việc".tr,
                    hintText: "",
                    isEdit: false,
                    onTap: (){
                      showMealShiftDialog(context,
                              // ignore: missing_return
                              (v) {
                            controller.chooseShift.value = v;
                            controller.chooseScheduleCl.text =
                                v.name;
                          });
                    },
                    controller: controller.chooseScheduleCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 22),
                    // controller: controller.genderEdt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    suffixIcon: IconButton(
                      color: Theme.of(context).focusColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ), onPressed: () {  },
                    ),
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.none,
                    labelText: "Chọn loại cơm".tr,
                    hintText: "",
                    isEdit: false,
                    onTap: (){
                      showMealTypeDialog(context,
                              // ignore: missing_return
                              (v) {
                            controller.chooseMealTypeCl.text = v;
                          });
                    },
                    controller: controller.chooseMealTypeCl,
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 22),
                    // controller: controller.genderEdt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    suffixIcon: IconButton(
                      color: Theme.of(context).focusColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const Text(
                "Danh sách nhân viên",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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
              // Row(
              //   children: [
              //     Obx(() {
              //       return Checkbox(
              //         value: controller.chooseAll.value,
              //         onChanged: (bool value) {
              //           controller.chooseAll.value =
              //               !controller.chooseAll.value;
              //           for (var i in controller.employees.value.data) {
              //             i.isChoose = controller.chooseAll.value;
              //           }
              //           controller.employees.refresh();
              //         },
              //       );
              //     }),
              //     const Text(
              //       "Chọn tất cả",
              //       style: TextStyle(fontSize: 20, color: Colors.black),
              //     ),
              //   ],
              // ),
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
                    height: 200,
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
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    );
                  }),
                  BlockButtonWidget(
                    onPressed: () async {
                      controller.riceSignup(context);
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
          )),
    );
  }
}
