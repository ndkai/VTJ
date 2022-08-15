import 'package:flutter/material.dart';

import 'scroll_bar_style.dart';

class CustomScrollBar extends StatelessWidget {
  final ScrollController controller;
  final ScrollbarStyle scrollbarStyle;
  final Widget child;

  const CustomScrollBar({
    Key key,
    this.controller,
    this.scrollbarStyle,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scrollbarStyle?.thumbColor != null) {
      return RawScrollbar(
        controller: controller,
        isAlwaysShown: scrollbarStyle?.isAlwaysShown ?? false,
        thickness: scrollbarStyle?.thickness,
        radius: scrollbarStyle?.radius,
        thumbColor: scrollbarStyle?.thumbColor,
        child: child,
      );
    }

    return Scrollbar(
      controller: controller,
      isAlwaysShown: scrollbarStyle?.isAlwaysShown ?? false,
      thickness: scrollbarStyle?.thickness,
      radius: scrollbarStyle?.radius,
      child: child,
    );
  }
}
