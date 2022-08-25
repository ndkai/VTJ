import 'package:flutter/material.dart';

import '../../../../common/size_config.dart';

void showLoadingDialog(BuildContext context) {
  SizeConfig().init(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(SizeConfig.screenWidth * 0.05))),
        insetPadding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.27),
        content: Container(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.screenWidth * 0.4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/icons8-spinner-1--unscreen.gif",
                width: SizeConfig.screenWidth * 0.1,
              ),
            ],
          ),
        ),
      );
    },
  );
}
