import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../global_widgets/pages/base_page.dart';
import 'components/toggle_widget.dart';
import 'meals_functions_view.dart';

class MealStatisticView extends GetView<MealController> {
  const MealStatisticView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getMealStatistic(context);
    return BasePage(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Helper.changePage(context, const MealFunctionsView());
        },
      ),
      title: "Thống kê cơm",
      child: SizedBox(
          height: SizeConfig.screenHeight * 0.91,
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                primary: true,
                children: [
                  ToggleWidget(
                    onChanged: (n) {
                      controller.selectedStatic.value = n;
                    },
                    selected: 0,
                  ).marginOnly(bottom: 20),
                ],
              ).marginOnly(top: 15))),
    );
  }
}
