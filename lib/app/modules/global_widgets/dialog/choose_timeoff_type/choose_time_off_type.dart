// ignore_for_file: use_function_type_syntax_for_parameters, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:vkhealth/app/models/request_models/timeoff/time_off_type.dart';

import '../../../../../common/size_config.dart';
import 'body.dart';

void showTimeOffDialog(BuildContext context,List<TimeOffTypeData> schedule, Function onSuccessTap(TimeOffTypeData)){

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05))
        ),
        // insetPadding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.2),
        content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.4)
            ),
            child: TimeOffSelectBody(
              doctors: schedule,
              onSuccess: (val){
                onSuccessTap(val);
              },
            )
        ),
      );
    },
  );
}