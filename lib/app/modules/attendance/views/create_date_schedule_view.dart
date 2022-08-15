import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/attendance/views/component/data_item.dart';
import 'package:vkhealth/app/modules/global_widgets/text_field_widget.dart';

import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../../../common/ui.dart';
import '../../../models/response_models/attendance/employee_attendance.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/dialog/choose_scheduleGroup/choose_schedule_group_dialog.dart';
import '../../global_widgets/dialog/choose_shift/choose_shift_dialog.dart';
import '../../global_widgets/pages/base_page.dart';
import '../../global_widgets/search_widget.dart';
import '../controllers/attendance_controller.dart';
import 'component/employee_item.dart';

class CreateDateScheduleView extends GetView<AttendanceController> {
  final EmployeeAttendance employeeAttendance;
  const CreateDateScheduleView(this.employeeAttendance, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Tạo lịch làm việc",
      child: ListView(
        children: [
          const Text("Thông tin nhân viên", style: TextStyle(
              color: Colors.black,
              fontSize: 24
          ),),
          TextFieldWidget(
            keyboardType: TextInputType.none,
            labelText: "Mã nhân viên",
            hintText: "",
            initialValue: employeeAttendance.employee.code,
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
            initialValue: employeeAttendance.employee.name,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
            // controller: controller.genderEdt,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10,),
          const Text("Đăng kí làm việc", style: TextStyle(
              color: Colors.black,
              fontSize: 24
          ),),
          Obx(
              (){
                return dataItem("Ngày đăng kí", TextButton(child: Text(Helper.getVietnameseTime(controller.fromDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
                  DateTime now = DateTime.now();
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: now.subtract(const Duration(days: 10)),
                      maxTime: now.add(const Duration(days: 365)),
                      onChanged: (date) {}, onConfirm: (date) {
                        controller.fromDate.value = date;
                      }, currentTime: DateTime.now(), locale: LocaleType.vi);
                },),);
              }
          ),
          Obx(
              (){
                return TextFieldWidget(
                  keyboardType: TextInputType.none,
                  labelText: "Chọn ca làm việc".tr,
                  hintText: "",
                  initialValue: controller.chooseShift.value.name,
                  controller: controller.chooseScheduleCl,
                  labelStyle:
                  const TextStyle(color: Colors.grey, fontSize: 22),
                  // controller: controller.genderEdt,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      //ignore: missing_return
                      showShiftDialog(context, controller.shiftResponse.value.data, (v){
                        controller.chooseShift.value = v;
                        controller.chooseScheduleCl.text =  controller.chooseShift.value.name;
                      });
                    },
                    color: Theme.of(context).focusColor,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                  ),
                );
              }
          ),
          Row(
            children: [
              Obx((){
                return Checkbox(value: controller.overtimeCheck.value, onChanged: (v){
                  controller.overtimeCheck.value = !controller.overtimeCheck.value;
                });
              }),
              const Text("Đăng kí tăng ca", style: TextStyle(color: Colors.black, fontSize: 18),),
            ],
          ),
          Obx(
              (){
                if(controller.overtimeCheck.value){
                  return Column(
                    children: [
                      dataItem(
                        "Thời gian bắt đầu",
                        TextButton(
                          child: Text(
                            Helper.getHour(controller.startTime.value),
                            style: const TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          onPressed: () async {
                            TimeOfDay tod = await showTimePicker(
                                context: context,
                                initialTime: controller.startTime.value);
                            if (tod != null) {
                              controller.startTime.value = tod;
                            }
                          },
                        ),
                      ),
                      dataItem(
                        "Thời gian kết thúc",
                        TextButton(
                          child: Text(
                            Helper.getHour(controller.endTime.value),
                            style: const TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          onPressed: () async {
                            TimeOfDay tod = await showTimePicker(
                                context: context,
                                initialTime: controller.endTime.value);
                            if (tod != null) {
                              controller.endTime.value = tod;
                            }
                          },
                        ),
                      ),
                      dataItem(
                          "Hệ số lương",
                          DropdownButton<String>(
                              items:  ['1.0', '1.3', '1.5', '2.0', '2.15', '2.7', '3.0', '3.9'].map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val, style: const TextStyle(color: Colors.black, fontSize: 18),),
                                );
                              }).toList(),
                              value: controller.factor.value,
                              hint: Text(controller.factor.value, style: const TextStyle(color: Colors.black, fontSize: 18),),
                              onChanged: (newVal) {
                                controller.factor.value = newVal;
                              }),
                          showArrow: false
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx((){
                            return Checkbox(value: controller.mealSignUp.value, onChanged: (v){controller.mealSignUp.value = !controller.mealSignUp.value;});
                          }),
                          const Text("Đăng kí cơm tăng ca", style: TextStyle(color: Colors.black, fontSize: 18),),
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              }
          ),

          BlockButtonWidget(
            onPressed: () {
              controller.createSchedule(context, employeeAttendance);
            },
            color: Colors.blue,
            text: Text(
              "Xác nhận",
              style: Get.textTheme.headline6.merge(
                  TextStyle(color: Get.theme.primaryColor)),
            ),
            borderRadius: 10,
          ).paddingSymmetric(vertical: 15, horizontal: 10),
        ],
      ),
    );
  }
}
