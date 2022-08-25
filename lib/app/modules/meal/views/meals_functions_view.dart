import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../common/helper.dart';
import '../../../../common/size_config.dart';
import '../../attendance/controllers/attendance_controller.dart';
import '../../global_widgets/pages/base_page.dart';
import 'aditional_meal.dart';
import 'meal_sign_up_view.dart';

class MealFunctionsView extends GetView<AttendanceController> {
  const MealFunctionsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Chức năng",
      child: MediaQuery.removeViewPadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              item("Đăng kí cơm", onTap: () {
                Helper.changePage(context, const MealSignUpView());
              }),
              item("Đăng kí bổ sung", onTap: () {
                Helper.changePage(context, const AdditionalMealView());
              }),
            ],
          )),
    );
  }

  Widget item(String title, {Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black38, width: 0.5))),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.black54),
        ),
      ),
    );
  }
}
