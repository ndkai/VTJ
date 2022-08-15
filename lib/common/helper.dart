// ignore_for_file: avoid_print

import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../app/models/provice.dart';
import '../app/models/user_model.dart';
import '../app/services/auth_service.dart';
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

  static bool hourComparison(TimeOfDay t1, TimeOfDay t2) {
    if(t1.hour > t2.hour){
      return true;
    }
    if(t1.hour == t2.hour){
      if(t1.minute > t2.minute){
        return true;
      }
    }

    return false;
  }
  

  static void changePageWithPermission(Function function, String pageCode){
    final authService = Get.find<AuthService>();
    List<Role> permissions = authService.user.value.userInfo.permissions;
    if(permissions.firstWhere((element) => element.code == pageCode) != null){
      function();
    } else {
      Get.showSnackbar(Ui.RemindSnackBar(message: "Không có quyền truy cập chức năng này"));
    }
  }

  static bool checkHavePermission(String pageCode){
    final authService = Get.find<AuthService>();
    List<Role> permissions = authService.user.value.userInfo.permissions;
    return permissions.firstWhere((element) => element.code == pageCode) != null;
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

  static String getVietnameseTime(String isoString, {bool showYear = true}){
     try{
         DateTime dateTime = DateTime.parse(isoString);
         if(!showYear){
           return  "${dateTime.day}/${dateTime.month} ";
         }
         return "${dateTime.day}/${dateTime.month}/${dateTime.year} ";
     } catch(e){
       return "";
     }
  }

  static String getHourByDate(String isoDate){
    try{
     DateTime dateTime = DateTime.parse(isoDate);
      return "${dateTime.hour}:${dateTime.minute}";
    } catch(e){
      return "";
    }
  }

  static String getHour(TimeOfDay tod, {bool showSecond = false}){
    try{
      if(showSecond) {
        return "${tod.hour > 10 ? tod.hour : "0${tod.hour}"}:${tod.minute > 10 ? tod.minute : "0${tod.minute}"}";
      }
      return "${tod.hour > 10 ? tod.hour : "0${tod.hour}"}:${tod.minute > 10 ? tod.minute : "0${tod.minute}"}";
    } catch(e){
      return "";
    }
  }
  static String getHourByDateTime(DateTime datetime, {bool showSecond = false}){
    try{
      if(showSecond) {
        return "${datetime.hour > 10 ? datetime.hour : "0${datetime.hour}"}:${datetime.minute > 10 ? datetime.minute : "0${datetime.minute}"}";
      }
      return "${datetime.hour > 10 ? datetime.hour : "0${datetime.hour}"}:${datetime.minute > 10 ? datetime.minute : "0${datetime.minute}"}";
    } catch(e){
      return "";
    }
  }


  static String nonNullCheck(dynamic value){
    try{
       return value.toString();
    } catch(e){
      return "";
    }
  }

  static String getApiDate(DateTime dateTime){
    try{
      return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
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
