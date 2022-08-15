import 'package:flutter/material.dart';

class ListViewLayoutDelegate extends MultiChildLayoutDelegate {
  final double widgetHeight;
  final double widgetWidth;
  final double shadowHeight;

  ListViewLayoutDelegate(
      this.widgetHeight, this.widgetWidth, this.shadowHeight);

  @override
  void performLayout(Size size) {
    Size headerSize = Size.zero;
    Size dividerSize = Size.zero;
    if (hasChild(ListViewLayout.Header)) {
      headerSize = layoutChild(
        ListViewLayout.Header,
        BoxConstraints(
            maxWidth: widgetWidth, maxHeight: widgetHeight),
      );

      positionChild(
        ListViewLayout.Header,
        const Offset(0, 0),
      );
    }

    if (hasChild(ListViewLayout.Divider)) {
      layoutChild(
        ListViewLayout.Divider,
        BoxConstraints(
          maxWidth: widgetWidth,
        ),
      );

      positionChild(
        ListViewLayout.Divider,
        Offset(0, headerSize.height),
      );
    }

    if (hasChild(ListViewLayout.ListView)) {
      layoutChild(
        ListViewLayout.ListView,
        BoxConstraints(
          maxHeight: widgetHeight - headerSize.height,
          maxWidth: widgetWidth,
        ),
      );

      positionChild(
        ListViewLayout.ListView,
        Offset(0, headerSize.height + dividerSize.height),
      );
    }

    if (hasChild(ListViewLayout.Shadow)) {
      layoutChild(
        ListViewLayout.Shadow,
        BoxConstraints(
          maxHeight: shadowHeight,
          maxWidth: widgetWidth,
        ),
      );

      positionChild(
        ListViewLayout.Shadow,
        Offset(0, headerSize.height + dividerSize.height),
      );
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return this != oldDelegate;
  }
}

// ignore: constant_identifier_names
enum ListViewLayout { Header, ListView, Shadow, Divider }
