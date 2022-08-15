class AttendanceDetailSwagger {
  double totalCounts;
  List<Data> data;

  AttendanceDetailSwagger({this.totalCounts, this.data});

  AttendanceDetailSwagger.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
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

class Data {
  String id;
  String time;
  double temperature;
  int attendanceMethod;
  String note;
  Employee employee;
  String user;
  String unitId;
  String deviceId;

  Data(
      {this.id,
      this.time,
      this.temperature,
      this.attendanceMethod,
      this.note,
      this.employee,
      this.user,
      this.unitId,
      this.deviceId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    temperature = json['temperature'];
    attendanceMethod = json['attendanceMethod'];
    note = json['note'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    // user = json['user'];
    unitId = json['unitId'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['temperature'] = temperature;
    data['attendanceMethod'] = attendanceMethod;
    data['note'] = note;
    if (employee != null) {
      data['employee'] = employee.toJson();
    }
    data['user'] = user;
    data['unitId'] = unitId;
    data['deviceId'] = deviceId;
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
