import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vkhealth/app/models/request_models/meal/meal_statistic.dart';
import 'package:vkhealth/app/modules/meal/controllers/meal_controller.dart';
import 'package:vkhealth/common/size_config.dart';

import '../../../../common/helper.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/dialog/choose_scheduleGroup/choose_schedule_group_dialog.dart';
import '../../global_widgets/dialog/comfirm_dialog.dart';
import '../../global_widgets/pages/base_page.dart';
import 'components/meal_overall_widget.dart';
import 'components/overall_meal_statistic_view.dart';
import 'components/sub_meal_statistic_widget.dart';
import 'components/toggle_widget.dart';
import 'meals_functions_view.dart';

class SubMealView extends GetView<MealController> {
  final MealStatisticData data;
  const SubMealView(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Helper.changePage(context, const MealFunctionsView());
        },
      ),
      title: data.unit.name,
      child: SizedBox(
          height: SizeConfig.screenHeight * 0.91,
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                primary: true,
                children: [
                  SubMealStatisticWidget(
                    data: data.childUnits,
                  )
                ],
              ).marginOnly(top: 15))
      ),
    );
  }
}
