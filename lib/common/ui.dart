// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' hide OnTap;
import 'package:get/get.dart';

class Ui {
  static GetSnackBar SuccessSnackBar({String title = 'Thành công', String message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(message, style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline, size: 32, color: Get.theme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds:   3),
    );
  }

  static GetSnackBar ErrorSnackBar({String title = 'Lỗi', String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(message, style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Get.theme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar RemindSnackBar({String title = 'Nhắc nhở', String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message, style: Get.textTheme.caption.merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.orange,
      icon: const Icon(Icons.info_outline, size: 32, color: Colors.white  ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar defaultSnackBar({String title = 'Cảnh báo', String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6.merge(const TextStyle(color: Colors.black))),
      messageText: Text(message, style: Get.textTheme.caption.merge(const TextStyle(color: Colors.black))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded, size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar notificationSnackBar({String title = 'Notification', String message, OnTap onTap, Widget mainButton}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      onTap: onTap,
      mainButton: mainButton,
      titleText: Text(title.tr, style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message, style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static Color parseColor(String hexCode, {double opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF"))).withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: const Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: const Color(0xFFFFB24D)));
    }
    list.addAll(List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: const Color(0xFFFFB24D));
    }));
    return list;
  }

  static TextStyle getPriceStyle(TextStyle style) {
    if (style == null) {
      return Get.textTheme.subtitle2.merge(
        TextStyle(fontWeight: FontWeight.w300, fontSize: Get.textTheme.subtitle2.fontSize - 4),
      );
    } else {
      return style.merge(TextStyle(fontWeight: FontWeight.w300, fontSize: style.fontSize - 4));
    }
  }

  static BoxDecoration getBoxDecoration({Color color, double radius, Border border, Gradient gradient}) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration({String hintText = '', String errorText, IconData iconData, Widget suffixIcon, Widget suffix,
  Color iconColor = Colors.black}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.caption,
      prefixIcon: iconData != null ? Icon(iconData, color: iconColor, ).marginOnly(right: 14) : const SizedBox(),
      prefixIconConstraints: iconData != null ? const BoxConstraints.expand(width: 38, height: 38) : const BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  static Html applyHtml(String html, {TextStyle style, TextAlign textAlign, Alignment alignment = Alignment.centerLeft}) {
    CustomRenderMatcher pMatcher() => (context) => context.tree.element?.localName == "p";
    return Html(
      data: html.replaceAll('\r\n', '') ?? '',
      customRenders: {
        pMatcher(): CustomRender.widget(widget: (context, child) {
          return Text(
            context.tree.element.text,
            textAlign: textAlign,
            style: style == null ? Get.textTheme.bodyText1.merge(const TextStyle(fontSize: 11)) : style.merge(const TextStyle(fontSize: 11)),
          );
        }),
      },
      style: {
        "*": Style(
          textAlign: textAlign,
          alignment: alignment,
          color: style == null ? Get.theme.hintColor : style.color,
          fontSize: style == null ? const FontSize(16.0) : FontSize(style.fontSize),
          display: Display.INLINE_BLOCK,
          fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
          width: Get.width,
        ),
        "li": Style(
          textAlign: textAlign,
          lineHeight: LineHeight.normal,
          listStylePosition: ListStylePosition.OUTSIDE,
          fontSize: style == null ? const FontSize(14.0) : FontSize(style.fontSize),
          display: Display.BLOCK,
        ),
        "h4,h5,h6": Style(
          textAlign: textAlign,
          fontSize: style == null ? const FontSize(16.0) : FontSize(style.fontSize + 2),
        ),
        "h1,h2,h3": Style(
          textAlign: textAlign,
          lineHeight: LineHeight.number(2),
          fontSize: style == null ? const FontSize(18.0) : FontSize(style.fontSize + 4),
        ),
        "br": Style(
          height: 0,
        ),
      },
    );
  }

  static BoxFit getBoxFit(String boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static Html removeHtml(String html, {TextStyle style, TextAlign textAlign, Alignment alignment = Alignment.centerLeft}) {
    CustomRenderMatcher pMatcher() => (context) => context.tree.element?.localName == "p";
    return Html(
      data: html.replaceAll('\r\n', '') ?? '',
      customRenders: {
        pMatcher(): CustomRender.widget(widget: (context, child) {
          return Text(
            context.tree.element.text,
            textAlign: textAlign,
            style: style == null ? Get.textTheme.bodyText1.merge(const TextStyle(fontSize: 11)) : style.merge(const TextStyle(fontSize: 11)),
          );
        }),
      },
      style: {
        "*": Style(
          textAlign: textAlign,
          alignment: alignment,
          color: style == null ? Get.theme.hintColor : style.color,
          fontSize: style == null ? const FontSize(11.0) : FontSize(style.fontSize),
          display: Display.INLINE_BLOCK,
          fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
          width: Get.width,
        ),
        "br": Style(
          height: 0,
        ),
      },
    );
  }

  static AlignmentDirectional getAlignmentDirectional(String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }
}
