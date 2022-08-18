import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/user_model.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';

import '../../../../common/helper.dart';
import '../../../models/response_models/attendance/employee_attendance.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/pages/base_page.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/attendance_controller.dart';
import 'component/data_item.dart';

class DateOverTimeView extends GetView<AttendanceController>{
  final Attendances attendances;
  final Employee employee;
  const DateOverTimeView(this.attendances, this.employee, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.getAttendanceDetailed(context);
    return BasePage(
      title: "Đăng kí tăng ca",
      child: Obx(
              (){
            if(controller.getAttendanceLoading.value){
              return const CircularLoadingWidget(height: 300,);
            } else {
              return ListView(
                children: [
                  const Text("Thông tin nhân viên", style: TextStyle(
                      color: Colors.black,
                    fontSize: 24
                  ),),
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
                  const SizedBox(height: 10,),
                  const Text("Thời gian đăng kí", style: TextStyle(
                      color: Colors.black,
                      fontSize: 24
                  ),),
                  dataItem(
                    "Thời gian bắt đầu",
                    TextButton(
                      child: Text(
                        Helper.getHour(controller.startTime.value),
                        style: const TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      onPressed: () async {
                        DateTime dt = await DatePicker.showTimePicker(context, showSecondsColumn: false, locale: LocaleType.vi);
                        if(dt!= null){
                          controller.startTime.value = TimeOfDay(hour: dt.hour,minute: dt.minute);
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
                        DateTime dt = await DatePicker.showTimePicker(context, showSecondsColumn: false, locale: LocaleType.vi);
                        if(dt!= null){
                          controller.endTime.value = TimeOfDay(hour: dt.hour,minute: dt.minute);
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
                  BlockButtonWidget(
                    onPressed: () async {
                      await controller.overtimeSignUpWhenHaveSchedule(context, attendances);
                      Navigator.of(context).pop();
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
              );
            }
          }
      ),
    );
  }


}