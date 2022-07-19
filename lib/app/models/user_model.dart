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

  User({this.token, this.tokenType, this.expiresIn, this.userInfo});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['tokenType'];
    expiresIn = json['expiresIn'];
    userInfo = json['userInfo'] != null
        ? UserInfo.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['tokenType'] = tokenType;
    data['expiresIn'] = expiresIn;
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
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
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
  String positionId;
  String siteId;
  String unitId;
  String scheduleGroupId;

  Employee(
      {this.id,
        this.code,
        this.name,
        this.positionId,
        this.siteId,
        this.unitId,
        this.scheduleGroupId});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    positionId = json['positionId'];
    siteId = json['siteId'];
    unitId = json['unitId'];
    scheduleGroupId = json['scheduleGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['positionId'] = positionId;
    data['siteId'] = siteId;
    data['unitId'] = unitId;
    data['scheduleGroupId'] = scheduleGroupId;
    return data;
  }
}
