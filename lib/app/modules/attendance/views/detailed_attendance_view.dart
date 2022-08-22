import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:vkhealth/app/modules/global_widgets/circular_loading_widget.dart';

import '../../global_widgets/pages/base_page.dart';
import '../controllers/attendance_controller.dart';

class DetailedAttendanceView extends GetView<AttendanceController> {
  const DetailedAttendanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.getAttendanceDetailed(context);
    return BasePage(
      title: "Chi tiết l",
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      child: Obx(() {
        if (controller.getAttendanceLoading.value) {
          return const CircularLoadingWidget(
            height: 300,
          );
        } else {
          return ListView(
            children: const [
              Text(
                "Thông tin nhân viên",
                style: TextStyle(color: Colors.black),
              ),
            ],
          );
        }
      }),
    );
  }
}
