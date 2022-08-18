// ignore_for_file: use_function_type_syntax_for_parameters, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../../../common/size_config.dart';
import 'body.dart';

void showChooseStringDialog(BuildContext context,List<String> list, Function onSuccessTap(String)){

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05))
        ),
        insetPadding: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.4, horizontal: SizeConfig.screenWidth * 0.15),
        content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.4)
            ),
            child: MealTypeSelectBody(
              list: list,
              onSuccess: (val){
                onSuccessTap(val);
              },
            )
        ),
      );
    },
  );
}