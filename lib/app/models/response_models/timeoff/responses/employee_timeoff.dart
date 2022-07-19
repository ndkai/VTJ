import '../../../user_model.dart';

class EmployeeTimeOffSwagger {
  double totalCounts;
  List<EmployeeTimeOff> data;

  EmployeeTimeOffSwagger({this.totalCounts, this.data});

  EmployeeTimeOffSwagger.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <EmployeeTimeOff>[];
      json['data'].forEach((v) {
        data.add(EmployeeTimeOff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCounts'] = totalCounts;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeTimeOff {
  String id;
  String fromDate;
  String toDate;
  bool isAbsenteeism;
  String note;
  Null sign;
  String dateOfSign;
  Type type;
  List<Logs> logs;
  Employee employee;

  EmployeeTimeOff(
      {this.id,
        this.fromDate,
        this.toDate,
        this.isAbsenteeism,
        this.note,
        this.sign,
        this.dateOfSign,
        this.type,
        this.logs,
        this.employee});

  EmployeeTimeOff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    isAbsenteeism = json['isAbsenteeism'];
    note = json['note'];
    sign = json['sign'];
    dateOfSign = json['dateOfSign'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs.add(Logs.fromJson(v));
      });
    }
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['isAbsenteeism'] = isAbsenteeism;
    data['note'] = note;
    data['sign'] = sign;
    data['dateOfSign'] = dateOfSign;
    if (type != null) {
      data['type'] = type.toJson();
    }
    if (logs != null) {
      data['logs'] = logs.map((v) => v.toJson()).toList();
    }
    if (employee != null) {
      data['employee'] = employee.toJson();
    }
    return data;
  }
}

class Type {
  String id;
  String abbreviation;
  String description;
  int amount;
  double factor;
  bool isCalculatedAttendance;

  Type(
      {this.id,
        this.abbreviation,
        this.description,
        this.amount,
        this.factor,
        this.isCalculatedAttendance});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbreviation = json['abbreviation'];
    description = json['description'];
    amount = json['amount'];
    factor = json['factor'];
    isCalculatedAttendance = json['isCalculatedAttendance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['abbreviation'] = abbreviation;
    data['description'] = description;
    data['amount'] = amount;
    data['factor'] = factor;
    data['isCalculatedAttendance'] = isCalculatedAttendance;
    return data;
  }
}

class Logs {
  String dateCreated;
  int status;
  Null note;
  User user;

  Logs({this.dateCreated, this.status, this.note, this.user});

  Logs.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    status = json['status'];
    note = json['note'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateCreated'] = dateCreated;
    data['status'] = status;
    data['note'] = note;
    if (user != null) {
      data['user'] = user.toJson();
    }
    return data;
  }
}

class User {
  String id;
  String username;
  String role;
  User({this.id, this.username, this.role,});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['role'] = role;
    return data;
  }
}
