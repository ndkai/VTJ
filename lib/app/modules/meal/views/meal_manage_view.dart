// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';
import 'package:vkhealth/app/modules/meal/views/sub_meal_view.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/dialog/choose_scheduleGroup/choose_schedule_group_dialog.dart';
import '../../global_widgets/dialog/comfirm_dialog.dart';
import '../../global_widgets/pages/base_page.dart';
import 'components/meal_overall_widget.dart';
import 'components/overall_meal_statistic_view.dart';
import 'components/toggle_widget.dart';
import 'meals_functions_view.dart';

class MealManagePage extends GetView<MealController> {
  const MealManagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getScheduleGroup(context);
    return BasePage(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Helper.changePage(context, const MealFunctionsView());
        },
      ),
      title: "Quản lý cơm",
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.91,
        child: Obx(() {
          return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                primary: true,
                children: [
                  ToggleWidget(
                    onChanged: (n) {
                      controller.selectedStatic.value = n;
                    },
                    selected: controller.selectedStatic.value,
                  ).marginOnly(bottom: 20),
                  Obx(() {
                    if (controller.selectedStatic.value == 0) {
                      return signWidget(context);
                    }
                    return statisticWidget(context);
                  })
                ],
              ).marginOnly(top: 15));
        }),
      ),
    );
  }

  Widget signWidget(BuildContext context) {
    controller.getOverviewMeal(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                showScheduleGroupDialog(context, controller.scheduleGroup, (v) {
                  controller.currentScheduleGroup.value = v;
                  controller.getOverviewMeal(context);
                });
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.5,
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Obx(() {
                  if (controller.currentScheduleGroup.value.name == null) {
                    return Container();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.currentScheduleGroup.value.code,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            controller.currentScheduleGroup.value.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 14,
                                overflow: TextOverflow.fade),
                          ),
                          Text(
                            "${controller.currentScheduleGroup.value.employeeIds.length} nhân viên",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 14,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.currentDate.value = controller
                              .currentDate.value
                              .subtract(const Duration(days: 1));
                          controller.getOverviewMeal(context);
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            size: 17, color: Colors.black54),
                      ),
                      Obx(() {
                        return Text(
                          Helper.getVietnameseTime(
                              controller.currentDate.value.toIso8601String()),
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                        );
                      }),
                      InkWell(
                        onTap: () {
                          controller.currentDate.value = controller
                              .currentDate.value
                              .add(const Duration(days: 1));
                          controller.getOverviewMeal(context);
                        },
                        child: const Icon(Icons.arrow_forward_ios,
                            size: 17, color: Colors.black54),
                      ),
                      Row(
                        children: const [],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      showComfirmDialog(
                          context, "Có chắn chắn muốn xác nhận đăng kí?",
                          onSuccessTap: () {
                        controller.comfirmSignUp(context);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Xác nhận",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(() {
          if (controller.getMealOverviewLoading.value) {
            return const CircularLoadingWidget(
              height: 500,
            );
          }
          if (controller.mealOverView.value.data == null) {
            return Container();
          }
          return TimeOffOverviewWidget(
            overView: controller.mealOverView.value,
            onChanged: (l) {
              controller.mealOverView.value = l;
            },
          );
        })
      ],
    );
  }

  Widget statisticWidget(BuildContext context) {
    controller.getMealStatistic(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.currentDate.value = controller
                              .currentDate.value
                              .subtract(const Duration(days: 1));
                          controller.getOverviewMeal(context);
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            size: 17, color: Colors.black54),
                      ),
                      Obx(() {
                        return Text(
                          Helper.getVietnameseTime(
                              controller.currentDate.value.toIso8601String()),
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 17),
                        );
                      }),
                      InkWell(
                        onTap: () {
                          controller.currentDate.value = controller
                              .currentDate.value
                              .add(const Duration(days: 1));
                          controller.getOverviewMeal(context);
                        },
                        child: const Icon(Icons.arrow_forward_ios,
                            size: 17, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(() {
          if (controller.mealStatisticLoading.value) {
            return const CircularLoadingWidget(
              height: 500,
            );
          }
          if (controller.mealStatistic.value.data == null) {
            return Container();
          }
          return OverallMealStatisticView(
            data: controller.mealStatistic.value.data.data,
            onChanged: (l) {
              Helper.changePage(context, SubMealView(l));
            },
          );
        })
      ],
    );
  }
}
