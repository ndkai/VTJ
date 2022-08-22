import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../controllers/timeoff_controller.dart';
import 'have_salary_do_view.dart';

class UserTimeOffViewManager extends GetView<TimeOffController> {
  const UserTimeOffViewManager({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getTimeOffType();
    controller.context = context;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Helper.changePage(context, const HaveSalaryDOView());
          },
        ),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Text(
                'Tất cả',
                style: TextStyle(fontSize: 12, color: Colors.white),
              )),
              Tab(
                  icon: Text(
                'Chờ duyệt',
                style: TextStyle(fontSize: 12, color: Colors.white),
              )),
              Tab(
                  icon: Text(
                'Thành công',
                style: TextStyle(fontSize: 12, color: Colors.white),
              )),
              Tab(
                  icon: Text(
                'Từ chối',
                style: TextStyle(fontSize: 12, color: Colors.white),
              )),
            ],
            indicatorColor: Colors.white,
          ),
          title: const Text(
            'Quản lý nghỉ phép',
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            item(context),
            item(context, id: 1),
            item(context, id: 3),
            item(context, id: 4),
          ],
        ),
      ),
    );
  }

  Widget item(BuildContext context, {int id, Function onTap}) {
    return Obx(() {
      if (controller.getEmployeeTOLoading.value) {
        return const CircularLoadingWidget(
          height: 300,
        );
      }
      if (controller.employeesTimeOff == null) {
        return Container();
      }
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  controller.currentWeek.value =
                      controller.currentWeek.value.previous;
                  controller.getEmployeeTimeOff(context);
                },
                child: const Icon(Icons.arrow_back_ios,
                    size: 17, color: Colors.black54),
              ),
              Obx(() {
                return Text(
                  "${Helper.getVietnameseTime(controller.currentWeek.value.days.first.toIso8601String(), showYear: false)} - ${Helper.getVietnameseTime(
                    controller.currentWeek.value.days.last.toIso8601String(),
                  )}",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                );
              }),
              InkWell(
                onTap: () {
                  controller.currentWeek.value =
                      controller.currentWeek.value.next;
                  controller.getEmployeeTimeOff(context);
                },
                child: const Icon(Icons.arrow_forward_ios,
                    size: 17, color: Colors.black54),
              ),
              Row(
                children: const [],
              )
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 8),
          Expanded(
              child: ListView(
            children: (id != null
                    ? controller.employeesTimeOff
                        .where((element) => element.logs.last.status == id)
                    : controller.employeesTimeOff)
                .map((e) {
              return InkWell(
                onTap: onTap,
                child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 40,
                            offset: const Offset(0, 15)),
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 13,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.type.description,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w200),
                        ).marginOnly(bottom: 10),
                        rowField("Nhân viên", e.employee.name),
                        rowField("Lý do nghỉ", e.type.description),
                        rowField("Từ ngày - đến ngày",
                            "${Helper.getVietnameseTime(e.fromDate)} - ${Helper.getVietnameseTime(e.toDate)}"),
                        rowField(
                            "Tổng ngày",
                            (DateTime.parse(e.toDate)
                                        .difference(DateTime.parse(e.fromDate))
                                        .inDays +
                                    1)
                                .toString()),
                        rowField("Trạng thái",
                            controller.mapStatusToState(e.logs.last.status),
                            contentColor: controller
                                .mapStatusToColor(e.logs.last.status)),
                      ],
                    )),
              );
            }).toList(),
          ))
        ],
      );
    });
  }

  Widget rowField(String title, String content,
      {Color contentColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black45, fontSize: 12),
        ),
        Text(
          "$content       ",
          style: TextStyle(color: contentColor, fontSize: 12),
        ),
      ],
    ).marginOnly(bottom: 10);
  }
}
