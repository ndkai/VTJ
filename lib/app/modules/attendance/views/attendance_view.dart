  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoweek/isoweek.dart';
import 'package:vkhealth/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';
import 'package:vkhealth/app/modules/global_widgets/dialog/choose_scheduleGroup/choose_schedule_group_dialog.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import 'component/attendance_widget.dart';


class AttendanceView extends GetView<AttendanceController>{
  const AttendanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getEmployeesAttendance(context, "83e62198-5b04-4a66-a31b-4de3dcebb05b");
    controller.getScheduleGroup(context);
    return BasePage(
      title: "Chấm công",
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  showScheduleGroupDialog(context, controller.scheduleGroup, (v){});
                },
                child: Container(
                  width: SizeConfig.screenWidth * 0.6,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue,
                          width: 1
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("123123", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Bảo vệ HC", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),),
                          Text("4 nhân viên", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),),
                        ],
                      )

                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        controller.currentDate.value = controller.currentDate.value.subtract(const Duration(days: 1));
                      },
                      child: const Icon(Icons.arrow_back_ios, size: 17,color: Colors.black54),
                    ),
                    Obx(
                            (){
                          return Text(Helper.getVietnameseTime(controller.currentDate.value.toIso8601String()), style: const TextStyle(color: Colors.black54, fontSize: 17),);
                        }
                    ),
                    InkWell(
                      onTap: (){
                        controller.currentDate.value =  controller.currentDate.value.add(const Duration(days: 1));
                      },
                      child: const Icon(Icons.arrow_forward_ios, size: 17,color: Colors.black54),
                    ),
                    Row(
                      children: [

                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Obx((){
            if(controller.employeesAttendance.isEmpty){
              return const CircularLoadingWidget(height: 500,);
            }
            return AttendanceWidget(week: Week.current(), employeesAttendance: controller.employeesAttendance,);
          })
        ],
      ),
    );
  }


}