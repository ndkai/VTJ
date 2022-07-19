// ignore_for_file: avoid_print

import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../app/models/provice.dart';
import 'ui.dart';

class Helper {
  DateTime currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    print(files);
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String getWeekDateString(int wd) {
    switch(wd) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
        
    }
    return "";
      
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static void changePage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String getVietnameseTime(String isoString){
     try{
         DateTime dateTime = DateTime.parse(isoString);
         return "${dateTime.day}/${dateTime.month}/${dateTime.year} ";
     } catch(e){
       return "";
     }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Nhấn lần nữa để thoát!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  Future<Provinces> getProvinceFormJson(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/hanhchinhvn/locations.json");
    final jsonResult = jsonDecode(data);
    Provinces provinces = Provinces.fromJson(jsonResult);
    print("getProvinceFormJson ${provinces.provinces.length}");
    return provinces;
  }
}
