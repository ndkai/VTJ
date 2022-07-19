import 'package:flutter/material.dart';

import '../../../../common/size_config.dart';
import '../buttons/big_button.dart';
import '../text/gradient_text.dart';

void showAppSuccesDialog(BuildContext context,
    {String title = "", Function historyTap, Function homepageTap}) {
  showDialog<void>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Center(
          child: GradientText(
            title,
            gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.purple,
                  Colors.orange,
                  
                ],
                // stops: [0.0, 1.0, -1],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated
            ),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            // textAlign: TextAlign.center,

          ),
        ),
        content: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.4,
          child: Column(
            children: [
              Image.asset(
                "assets/illustration/success_inslustration.png",
                height: SizeConfig.screenHeight * 0.2,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              BigButton(
                title: "Lịch sử",
                onTap: historyTap,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              InkWell(
                onTap: () {
                  homepageTap();
                },
                child: Text(
                  "Trang chủ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
