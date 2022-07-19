import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/global_widgets/pages/base_page.dart';
import 'package:vkhealth/app/modules/timeoff/views/have_salary_do_view.dart';
import 'package:vkhealth/common/helper.dart';
import 'package:vkhealth/common/size_config.dart';

import '../controllers/timeoff_controller.dart';

class MakeTimeOffView extends GetView<TimeOffController> {
  const MakeTimeOffView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Tạo nghỉ phép",
      child: Column(
        children: [
          const SizedBox(height: 20,),
          item("Nghỉ phép có lương", onTap: () => Helper.changePage(context, const HaveSalaryDoView())),
          item("Nghỉ phép không lương", onTap: () => Helper.changePage(context, const HaveSalaryDoView())),
          item("Nghỉ thai sản "),
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
