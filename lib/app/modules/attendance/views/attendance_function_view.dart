import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:vkhealth/app/modules/attendance/views/create_overtime_view.dart';

import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../global_widgets/pages/base_page.dart';
import '../controllers/attendance_controller.dart';
import 'create_work_schedule_view.dart';

class AttendanceFunctionView extends GetView<AttendanceController>{
  const AttendanceFunctionView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Chức năng",
      child: ListView(
        children: [
          item("Đăng kí lịch làm việc", onTap: (){
            Helper.changePage(context, const CreateWorkScheduleView());
          }),
          item("Đăng kí tăng ca", onTap: (){
            Helper.changePage(context, const CreateOvertimeView());
          }),
        ],
      ),
    );
  }

  Widget item(String title, {Function onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black38, width: 0.5)
            )
        ),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.w200
          ),
        ),
      ),
    );
  }

}