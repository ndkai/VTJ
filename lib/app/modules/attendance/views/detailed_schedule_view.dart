import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/response_models/attendance/employee_attendance.dart';

import '../../../../common/helper.dart';
import '../../../models/user_model.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/pages/base_page.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/attendance_controller.dart';
import 'component/attendance_fixed_dialog.dart';
import 'component/data_item.dart';

class DetailedScheduleView extends GetView<AttendanceController> {
  final Attendances employeeAttendance;
  final Employee employee;

  const DetailedScheduleView(this.employeeAttendance, this.employee, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAttendanceDetailed(context,
        employeeAttendance.schedule.employeeId, employeeAttendance.date);
    return BasePage(
      title: "Chi tiết lịch làm việc",
      child: Obx(() {
        if (controller.attendanceDetailedLoading.value) {
          return const CircularLoadingWidget(
            height: 300,
          );
        } else {
          return ListView(
            children: [
              const Text(
                "Thông tin nhân viên",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
              TextFieldWidget(
                keyboardType: TextInputType.none,
                labelText: "Mã nhân viên",
                hintText: "",
                initialValue: employee.code,
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
                // controller: controller.genderEdt,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              TextFieldWidget(
                keyboardType: TextInputType.none,
                labelText: "Họ và tên",
                hintText: "",
                initialValue: employee.name,
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
                // controller: controller.genderEdt,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              const Text(
                "Lịch làm việc",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ).paddingSymmetric(vertical: 10),
              TextFieldWidget(
                keyboardType: TextInputType.none,
                isEdit: false,
                labelText: "Tên ca",
                hintText: "",
                initialValue: employeeAttendance.schedule != null &&
                        employeeAttendance.schedule.shift != null
                    ? employeeAttendance.schedule.shift.name
                    : "",
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
                // controller: controller.genderEdt,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),

              dataItem(
                  "Giờ vào:",
                  Text(
                      employeeAttendance.schedule != null &&
                              employeeAttendance.schedule.shift != null
                          ? employeeAttendance.schedule.shift.timeBegin
                              .substring(0, 5)
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),
              dataItem(
                  "Giờ ra:",
                  Text(
                      employeeAttendance.schedule != null &&
                              employeeAttendance.schedule.shift != null
                          ? employeeAttendance.schedule.shift.timeEnd
                              .substring(0, 5)
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),
              dataItem(
                  "Tổng thời gian:",
                  Text(
                      employeeAttendance.schedule != null &&
                              employeeAttendance.schedule.shift != null
                          ? employeeAttendance.schedule.shift.workingHours
                              .toString()
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),

              Row(
                children: [
                  const Text(
                    "Chấm công thực tế    ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black),
                  ).paddingSymmetric(vertical: 10),
                  InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                              content: AttendanceFixedDialog(
                            checkIn: employeeAttendance.statistic.checkIn,
                            checkout: employeeAttendance.statistic.checkOut,
                            date: DateTime.parse(employeeAttendance.date),
                            onTapDone: (note, ci, co) {
                              controller.attendanceManual(context, note:  note,
                              ciTime: ci, coTime: co, employeeId: employee.id, id: employeeAttendance.schedule.employeeId,
                                  date: employeeAttendance.date);
                            },
                          ));
                        },
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  )
                ],
              ),
              dataItem(
                  "Nhiệt độ vào:",
                  Text(
                      employeeAttendance.statistic != null &&
                              employeeAttendance.statistic.checkIn != null
                          ? employeeAttendance.statistic.checkIn.temperature
                              .toString()
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),
              dataItem(
                  "Nhiệt độ ra:",
                  Text(
                      employeeAttendance.statistic != null &&
                              employeeAttendance.statistic.checkOut != null
                          ? employeeAttendance.statistic.checkOut.temperature
                              .toString()
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),

              dataItem(
                  "Giờ vào:",
                  Text(
                      employeeAttendance.statistic != null &&
                              employeeAttendance.statistic.checkIn != null
                          ? Helper.getHourByDate(
                              employeeAttendance.statistic.checkIn.time)
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),
              dataItem(
                  "Giờ ra:",
                  Text(
                      employeeAttendance.statistic != null &&
                              employeeAttendance.statistic.checkOut != null
                          ? Helper.getHourByDate(
                              employeeAttendance.statistic.checkOut.time)
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),
              dataItem(
                  "Tổng thời gian:",
                  Text(
                      employeeAttendance.statistic != null &&
                              employeeAttendance.statistic.checkOut != null
                          ? employeeAttendance.statistic.workingHours
                              .toStringAsFixed(1)
                          : "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  showArrow: false),
              // const Text("Thông tin ca đăng kí", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),),
              // dataItem("Ngày", TextButton(child: Text(Helper.getVietnameseTime(controller.fromDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
              // },),),
              // dataItem("Thời gian bắt đầu", TextButton(child: Text(Helper.getVietnameseTime(controller.fromDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
              //   DateTime now = DateTime.now();
              //   DatePicker.showDatePicker(context,
              //       showTitleActions: true,
              //       minTime: now.subtract(const Duration(days: 10)),
              //       maxTime: now.add(const Duration(days: 365)),
              //       onChanged: (date) {}, onConfirm: (date) {
              //         controller.fromDate.value = date;
              //       }, currentTime: DateTime.now(), locale: LocaleType.vi);
              // },),),
              // dataItem("Thời gian kết thúc", TextButton(child: Text(Helper.getVietnameseTime(controller.fromDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
              //   DateTime now = DateTime.now();
              //   DatePicker.showDatePicker(context,
              //       showTitleActions: true,
              //       minTime: now.subtract(const Duration(days: 10)),
              //       maxTime: now.add(const Duration(days: 365)),
              //       onChanged: (date) {}, onConfirm: (date) {
              //         controller.fromDate.value = date;
              //       }, currentTime: DateTime.now(), locale: LocaleType.vi);
              // },),),
              // dataItem("Số giờ", const Text("00",
              //     style: TextStyle(color: Colors.blue, fontSize: 18)), showArrow: false),
              // dataItem("Hệ số lương", const Text("11",
              //   style: TextStyle(color: Colors.blue, fontSize: 18),), showArrow: false),
              const SizedBox(
                height: 40,
              ),
              // BlockButtonWidget(
              //   onPressed: () {},
              //   color: Get.theme.colorScheme.secondary,
              //   text: Text(
              //     "Xác nhận",
              //     style: Get.textTheme.headline6
              //         .merge(TextStyle(color: Get.theme.primaryColor)),
              //   ),
              // ).paddingSymmetric(vertical: 10, horizontal: 20),
            ],
          );
        }
      }),
    );
  }
}
