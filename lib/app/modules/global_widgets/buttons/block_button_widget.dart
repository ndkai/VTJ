import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({Key key, @required this.color, @required this.text, @required this.onPressed, this.borderRadius = 20}) : super(key: key);
  final double borderRadius;
  final Color color;
  final Widget text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: onPressed != null
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 15)),
                BoxShadow(color: color.withOpacity(0.2), blurRadius: 13, offset: const Offset(0, 3))
              ],
              // borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
        color: color,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        child: text,
        elevation: 0,
      ),
    );
  }
}
