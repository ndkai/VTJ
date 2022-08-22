// ignore_for_file: prefer_void_to_null

import 'package:vkhealth/app/models/response_models/attendance/schedule_swagger.dart';

class UserSwagger {
  User data;

  UserSwagger({this.data});

  UserSwagger.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class User {
  String token;
  String tokenType;
  int expiresIn;
  UserInfo userInfo;
  bool auth;
  String dateExpired;

  User(
      {this.token,
      this.tokenType,
      this.expiresIn,
      this.userInfo,
      this.dateExpired});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['tokenType'];
    dateExpired = json['dateExpired'];
    expiresIn = json['expiresIn'];
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['tokenType'] = tokenType;
    data['expiresIn'] = expiresIn;
    data['dateExpired'] = dateExpired;
    if (userInfo != null) {
      data['userInfo'] = userInfo.toJson();
    }
    return data;
  }
}

class UserInfo {
  String id;
  String username;
  String fullname;
  Role role;
  List<Role> permissions;
  Employee employee;

  UserInfo(
      {this.id,
      this.username,
      this.fullname,
      this.role,
      this.permissions,
      this.employee});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullname = json['fullname'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    if (json['permissions'] != null) {
      permissions = <Role>[];
      json['permissions'].forEach((v) {
        permissions.add(Role.fromJson(v));
      });
    }
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullname'] = fullname;
    if (role != null) {
      data['role'] = role.toJson();
    }
    if (permissions != null) {
      data['permissions'] = permissions.map((v) => v.toJson()).toList();
    }
    if (employee != null) {
      data['employee'] = employee.toJson();
    }
    return data;
  }
}

class Role {
  String id;
  String code;
  String description;

  Role({this.id, this.code, this.description});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    return data;
  }
}

class Employee {
  String id;
  String code;
  String name;
  String image;
  Position position;
  Site site;
  Unit unit;
  ScheduleGroup scheduleGroup;
  String scheduleGroupId;

  Employee(
      {this.id,
      this.code,
      this.name,
      this.image,
      this.position,
      this.site,
      this.unit,
      this.scheduleGroupId,
      this.scheduleGroup});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    scheduleGroupId = json['scheduleGroupId'];
    image = json['image'];
    if (json['position'] != null) {
      position = Position.fromJson(json['position']);
    }
    if (json['site'] != null) {
      site = Site.fromJson(json['site']);
    }
    if (json['unit'] != null) {
      unit = Unit.fromJson(json['unit']);
    }
    if (json['scheduleGroup'] != null) {
      scheduleGroup = ScheduleGroup.fromJson(json['scheduleGroup']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['image'] = image;
    if (position != null) {
      data['position'] = position.toJson();
    }
    if (site != null) {
      data['site'] = site.toJson();
    }
    if (unit != null) {
      data['unit'] = unit.toJson();
    }
    if (scheduleGroup != null) {
      data['scheduleGroup'] = scheduleGroup.toJson();
    }
    return data;
  }
}

class Position {
  String id;
  String code;
  String name;
  String abbreviation;

  Position({this.id, this.code, this.name, this.abbreviation});

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    abbreviation = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['abbreviation'] = abbreviation;
    return data;
  }
}

class Site {
  String id;
  String code;
  String name;
  String address;
  int latitude;
  int longitude;

  Site(
      {this.id,
      this.code,
      this.name,
      this.address,
      this.latitude,
      this.longitude});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Unit {
  String id;
  String code;
  String name;
  int type;
  int prescribedPersonnel;
  int actualPersonnel;
  int unitPriceOfMeal;
  List<Null> childUnits;

  Unit(
      {this.id,
      this.code,
      this.name,
      this.type,
      this.prescribedPersonnel,
      this.actualPersonnel,
      this.unitPriceOfMeal,
      this.childUnits});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    prescribedPersonnel = json['prescribedPersonnel'];
    actualPersonnel = json['actualPersonnel'];
    unitPriceOfMeal = json['unitPriceOfMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['type'] = type;
    data['prescribedPersonnel'] = prescribedPersonnel;
    data['actualPersonnel'] = actualPersonnel;
    data['unitPriceOfMeal'] = unitPriceOfMeal;
    return data;
  }
}
