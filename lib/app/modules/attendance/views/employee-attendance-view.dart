// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import 'component/attendance_status_item.dart';
import 'component/attendance_widget.dart';

class EmployeeAttendanceView extends GetView<AttendanceController> {
  const EmployeeAttendanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.get1EmployeesAttendance(context);
    return BasePage(
      title: "Lịch làm việc",
      child: Obx(() {
        if (controller.getAttendanceLoading.value) {
          return const CircularLoadingWidget(
            height: 300,
          );
        }
        if (controller.employeesAttendance == null) {
          return Container();
        }
        return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Container(
                //   width: SizeConfig.screenWidth * 0.5,
                //   height: 70,
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //           color: Colors.blue,
                //           width: 1
                //       ),
                //       borderRadius: BorderRadius.circular(5)
                //   ),
                //   child: Obx(
                //           (){
                //         if(controller.currentScheduleGroup.value.name == null){
                //           return Container();
                //         }
                //         ScheduleGroup scheduleGroup = controller.scheduleGroup.firstWhere((element) => element.id == controller.currentUser.value.userInfo.employee.scheduleGroupId);
                //         return Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Text(controller.currentUser.value.userInfo.employee.scheduleGroup.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                //               children: [
                //                 Text(scheduleGroup.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, overflow: TextOverflow.fade),),
                //                 Text("${scheduleGroup.employeeIds.length} nhân viên", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16, overflow: TextOverflow.fade),),
                //               ],
                //             )
                //
                //           ],
                //         );
                //       }
                //   ),
                // ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.currentWeek.value =
                              controller.currentWeek.value.previous;
                          controller.getEmployeesAttendance(context);
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            size: 17, color: Colors.black54),
                      ),
                      Obx(() {
                        return Text(
                          "${Helper.getVietnameseTime(controller.currentWeek.value.days.first.toIso8601String(), showYear: false)} - ${Helper.getVietnameseTime(
                            controller.currentWeek.value.days.last
                                .toIso8601String(),
                          )}",
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 17),
                        );
                      }),
                      InkWell(
                        onTap: () {
                          controller.currentWeek.value =
                              controller.currentWeek.value.next;
                          controller.getEmployeesAttendance(context);
                        },
                        child: const Icon(Icons.arrow_forward_ios,
                            size: 17, color: Colors.black54),
                      ),
                      Row(
                        children: const [],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                AttendanceStatusItem(
                  color: Ui.parseColor("#94A3B8"),
                  title: "Không có ca làm việc",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#000000"),
                  title: "Ngày nghỉ",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#A61C4A"),
                  title: "Vắng mặt",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#B9859E"),
                  title: "Không có giờ ra",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#002987"),
                  title: "Không có giờ vào",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#FFBED4"),
                  title: "Chưa đến ca làm việc",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#FFBED4"),
                  title: "Về sớm",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#0037B3"),
                  title: "Về trể",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#05CE91"),
                  title: "Đúng giờ",
                  size: 10,
                ),
                AttendanceStatusItem(
                  color: Ui.parseColor("#41ADD1"),
                  title: "Về đúng giờ",
                  size: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              if (controller.getAttendanceLoading.value) {
                return const CircularLoadingWidget(
                  height: 500,
                );
              }
              return AttendanceWidget(
                week: controller.currentWeek.value,
                employeesAttendance: controller.employeesAttendance,
                haveFunction: false,
                deleteSchedule: (s) {
                  controller.deleteSchedule(context, s);
                },
              );
            })
          ],
        );
      }),
    );
  }
}
