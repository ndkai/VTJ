
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:vkhealth/app/modules/attendance/views/component/data_item.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/app/modules/global_widgets/search_widget.dart';
import 'package:vkhealth/common/size_config.dart';
import 'package:vkhealth/common/ui.dart';

import '../../../../common/app_constant.dart';
import '../../../../common/helper.dart';
import '../../global_widgets/buttons/block_button_widget.dart';
import '../../global_widgets/dialog/choose_shift/choose_shift_dialog.dart';
import '../../global_widgets/dialog/loading_dialog.dart';
import '../../global_widgets/text_field_widget.dart';
import 'component/employee_item.dart';


class CreateWorkScheduleView extends GetView<AttendanceController>{
  const CreateWorkScheduleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getEmployees();
    return BasePage(
      title: "Tạo Lịch Làm Việc",
      child: ListView(
        children: [
          const Text("Thông tin ca làm việc", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),),
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
                      // ignore: missing_return
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
          Column(
            children: [
              Obx(
                  (){
                    return dataItem("Từ ngày", TextButton(child: Text(Helper.getVietnameseTime(controller.fromDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
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
                    return dataItem("Đến ngày",  TextButton(child: Text(Helper.getVietnameseTime(controller.toDate.value.toIso8601String()), style: const TextStyle(color: Colors.blue, fontSize: 18),), onPressed: (){
                      DateTime now = DateTime.now();
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: now.subtract(const Duration(days: 10)),
                          maxTime: now.add(const Duration(days: 365)),
                          onChanged: (date) {}, onConfirm: (date) {
                            controller.toDate.value = date;
                          }, currentTime: DateTime.now(), locale: LocaleType.vi);
                    },),);
                  }
              ),
              const SizedBox(height: 10,),
            ],
          ),
          const Text("Ngày trong tuần", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),),
         Obx(
             (){
               return  Wrap(
                 children: [0,1,2,3,4,5,6].map((e) => ChoiceChip(
                   selected: controller.dayoffWeek.contains(e),
                   onSelected: (s){
                     if(controller.dayoffWeek.contains(e)){
                       controller.dayoffWeek.remove(e);
                     } else {
                       controller.dayoffWeek.add(e);
                     }
                   },
                   selectedColor: Colors.blue.withOpacity(.8),
                   disabledColor: Colors.grey.withOpacity(.1),
                   label: Text(AppConstants.dateInWeek[e], style: const TextStyle(color: Colors.black, fontSize: 18),),
                 ).marginAll(3)).toList(),
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
          const Text("Danh sách nhân viên", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),),
          const SizedBox(height: 5,),
          Row(
            children: [
              SearchWidget(
                title: "Nhập mã, tên để tìm kiếm",
                height: 40,
                width: SizeConfig.screenWidth * 0.7,
                onSummited: (s){
                   controller.getEmployeesByName(s);
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Ui.parseColor("#ebeced"),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Icon(
                  Icons.filter_alt_rounded,
                  size: 15,
                ),
              )
            ],
          ),
          Row(
            children: [
             Obx((){
               return  Checkbox(
                 value: controller.chooseAll.value, onChanged: (bool value) {
                 controller.chooseAll.value = !controller.chooseAll.value;
                 for(var i in controller.employees.value.data){
                   i.isChoose = controller.chooseAll.value;
                 }
                 controller.employees.refresh();
               },
               );
             }),
              const Text("Chọn tất cả", style: TextStyle(fontSize: 20, color: Colors.black),),
            ],
          ),
         Obx((){
           if(controller.getEmployeeLoading.value){
             return const CircularLoadingWidget(height: 50,);
           }
           if(controller.employees.value.data == null){
             return const Center(
               child: Text("Không có thông tin nhân viên", style: TextStyle(color: Colors.black45),),
             );
           }
           if(controller.employees.value.data.isNotEmpty){
             return  SizedBox(
               height: 300,
               child: Stack(
                 children: [
                   NotificationListener<ScrollEndNotification>(
                     onNotification: (scrollEnd) {
                       final metrics = scrollEnd.metrics;
                       if (metrics.atEdge) {
                         bool isEnd = metrics.pixels == controller.employeeScrollCl.position.maxScrollExtent;
                         if (isEnd) {
                           controller.loadMoreEmployee.value = true;
                           controller.getEmployees();
                         }
                       }
                       return true;
                     },
                     child: ListView(
                       children: controller.employees.value.data.map((e) => EmployeeItem(employeeData: e, key: Key(e.code), onChanged: (e){
                         controller.employees.value.data.firstWhere((element) => element.code == e.code).isChoose = e.isChoose;
                         controller.employees.refresh();

                       },)).toList(),
                       controller: controller.employeeScrollCl,
                     ),
                   ),
                   Obx(
                           (){
                         if(controller.loadMoreEmployee.value){
                           return Container(
                             height: 300,
                             width: SizeConfig.screenWidth,
                             color: Colors.grey.withOpacity(.2),
                             child: const Center(
                               child: CircularLoadingWidget(height: 30,),
                             ),
                           );
                         }
                         return Container();

                       }
                   )
                 ],
               ),
             );
           }
           return Container();
         }),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                  (){
                    return Text("Đã chọn(${controller.employees.value.data.where((element) => element.isChoose).toList().length})", style: const TextStyle(fontSize: 18, color: Colors.black),);
                  }
              ),
              BlockButtonWidget(
                onPressed: () async {
                  showLoadingDialog(context);
                  await controller.overTimeBatch(context);
                  Navigator.of(context).pop();

                },
                color: Get.theme.colorScheme.secondary,
                text: Text(
                  "Xác nhận",
                  style: Get.textTheme.headline6.merge(
                      TextStyle(color: Get.theme.primaryColor)),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10)
        ],
      ),
    );
  }





}