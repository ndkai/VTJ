import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dataItem(String title, Widget child, {bool showArrow = true}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(color: Colors.black54, fontSize: 18),),
      Row(
        children: [
          child,
          showArrow ?  const Icon(Icons.arrow_forward_ios_sharp, size: 15,) : Container(),
        ],
      )

    ],
  ).paddingSymmetric(vertical: 7, horizontal: 13);
}