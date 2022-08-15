import 'package:flutter/material.dart';

class TableBaseLayoutDelegate extends MultiChildLayoutDelegate {
  final double widgetHeight;
  final double widgetWidth;
  final double headerWidth;
  final double middleShadowWidth;

  TableBaseLayoutDelegate(
    this.widgetHeight,
    this.widgetWidth,
    this.headerWidth,
    this.middleShadowWidth,
  );

  @override
  void performLayout(Size size) {
    Size leftListViewSize = Size.zero;

    if (hasChild(BaseLayoutView.LeftListView)) {
      leftListViewSize = layoutChild(
        BaseLayoutView.LeftListView,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: headerWidth,
        ),
      );

      positionChild(
        BaseLayoutView.LeftListView,
        const Offset(0, 0),
      );
    }

    if (hasChild(BaseLayoutView.RightListView)) {
      layoutChild(
        BaseLayoutView.RightListView,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: widgetWidth - leftListViewSize.width,
        ),
      );

      positionChild(
        BaseLayoutView.RightListView,
        Offset(leftListViewSize.width, 0),
      );
    }

    if (hasChild(BaseLayoutView.MiddleShadow)) {
      layoutChild(
        BaseLayoutView.MiddleShadow,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: middleShadowWidth,
        ),
      );

      positionChild(
        BaseLayoutView.MiddleShadow,
        Offset(leftListViewSize.width, 0),
      );
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return this != oldDelegate;
  }
}

// ignore: constant_identifier_names
enum BaseLayoutView { LeftListView, RightListView, MiddleShadow, Divider }
