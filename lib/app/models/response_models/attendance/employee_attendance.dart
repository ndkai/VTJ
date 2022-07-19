import '../../user_model.dart';
import '../timeoff/responses/employee_timeoff.dart';

class EmployeeAttendanceSwagger {
  double totalCounts;
  List<EmployeeAttendance> data;

  EmployeeAttendanceSwagger({this.totalCounts, this.data});

  EmployeeAttendanceSwagger.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <EmployeeAttendance>[];
      json['data'].forEach((v) {
        data.add(EmployeeAttendance.fromJson(v));
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

class EmployeeAttendance {
  Employee employee;
  List<Attendances> attendances;

  EmployeeAttendance({this.employee, this.attendances});

  EmployeeAttendance.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    if (json['attendances'] != null) {
      attendances = <Attendances>[];
      json['attendances'].forEach((v) {
        attendances.add(Attendances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['employee'] = employee.toJson();
    }
    if (attendances != null) {
      data['attendances'] = attendances.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendances {
  String date;
  Statistic statistic;
  Schedule schedule;

  Attendances({this.date, this.statistic, this.schedule});

  Attendances.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    statistic = json['statistic'] != null
        ? Statistic.fromJson(json['statistic'])
        : null;
    schedule = json['schedule'] != null
        ? Schedule.fromJson(json['schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (statistic != null) {
      data['statistic'] = statistic.toJson();
    }
    if (schedule != null) {
      data['schedule'] = schedule.toJson();
    }
    return data;
  }
}

class Statistic {
  String id;
  int status;
  CheckIn checkIn;
  Null checkOut;
  int workingHours;
  int breakingHours;
  int overtimeWorkingHours;

  Statistic(
      {this.id,
      this.status,
      this.checkIn,
      this.checkOut,
      this.workingHours,
      this.breakingHours,
      this.overtimeWorkingHours});

  Statistic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    checkIn =
        json['checkIn'] != null ? CheckIn.fromJson(json['checkIn']) : null;
    checkOut = json['checkOut'];
    workingHours = json['workingHours'];
    breakingHours = json['breakingHours'];
    overtimeWorkingHours = json['overtimeWorkingHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    if (checkIn != null) {
      data['checkIn'] = checkIn.toJson();
    }
    data['checkOut'] = checkOut;
    data['workingHours'] = workingHours;
    data['breakingHours'] = breakingHours;
    data['overtimeWorkingHours'] = overtimeWorkingHours;
    return data;
  }
}

class CheckIn {
  String id;
  String time;
  double temperature;
  int attendanceMethod;
  Null note;
  Null employee;
  Null user;
  String unitId;
  String deviceId;

  CheckIn(
      {this.id,
      this.time,
      this.temperature,
      this.attendanceMethod,
      this.note,
      this.employee,
      this.user,
      this.unitId,
      this.deviceId});

  CheckIn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    temperature = json['temperature'];
    attendanceMethod = json['attendanceMethod'];
    note = json['note'];
    employee = json['employee'];
    user = json['user'];
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
    data['employee'] = employee;
    data['user'] = user;
    data['unitId'] = unitId;
    data['deviceId'] = deviceId;
    return data;
  }
}

class Schedule {
  String id;
  String date;
  String employeeId;
  Shift shift;
  Null overtimeShift;
  TimeOff timeOff;

  Schedule(
      {this.id,
      this.date,
      this.employeeId,
      this.shift,
      this.overtimeShift,
      this.timeOff});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    employeeId = json['employeeId'];
    shift = json['shift'] != null ? Shift.fromJson(json['shift']) : null;
    overtimeShift = json['overtimeShift'];
    timeOff =
        json['timeOff'] != null ? TimeOff.fromJson(json['timeOff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['employeeId'] = employeeId;
    if (shift != null) {
      data['shift'] = shift.toJson();
    }
    data['overtimeShift'] = overtimeShift;
    if (timeOff != null) {
      data['timeOff'] = timeOff.toJson();
    }
    return data;
  }
}

class Shift {
  String id;
  String code;
  String name;
  String colour;
  List<int> types;
  List<LimitedFactors> limitedFactors;
  bool isPeriodLock;
  String timeBegin;
  String timeEnd;
  int workingHours;
  int shortBreakingHours;
  int longBreakingHours;
  Null shiftDetails;

  Shift(
      {this.id,
      this.code,
      this.name,
      this.colour,
      this.types,
      this.limitedFactors,
      this.isPeriodLock,
      this.timeBegin,
      this.timeEnd,
      this.workingHours,
      this.shortBreakingHours,
      this.longBreakingHours,
      this.shiftDetails});

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    colour = json['colour'];
    types = json['types'].cast<int>();
    if (json['limitedFactors'] != null) {
      limitedFactors = <LimitedFactors>[];
      json['limitedFactors'].forEach((v) {
        limitedFactors.add(LimitedFactors.fromJson(v));
      });
    }
    isPeriodLock = json['isPeriodLock'];
    timeBegin = json['timeBegin'];
    timeEnd = json['timeEnd'];
    workingHours = json['workingHours'];
    shortBreakingHours = json['shortBreakingHours'];
    longBreakingHours = json['longBreakingHours'];
    shiftDetails = json['shiftDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['colour'] = colour;
    data['types'] = types;
    if (limitedFactors != null) {
      data['limitedFactors'] =
          limitedFactors.map((v) => v.toJson()).toList();
    }
    data['isPeriodLock'] = isPeriodLock;
    data['timeBegin'] = timeBegin;
    data['timeEnd'] = timeEnd;
    data['workingHours'] = workingHours;
    data['shortBreakingHours'] = shortBreakingHours;
    data['longBreakingHours'] = longBreakingHours;
    data['shiftDetails'] = shiftDetails;
    return data;
  }
}

class LimitedFactors {
  String name;
  int hour;

  LimitedFactors({this.name, this.hour});

  LimitedFactors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['hour'] = hour;
    return data;
  }
}

class TimeOff {
  String id;
  String fromDate;
  String toDate;
  bool isAbsenteeism;
  Null note;
  Null sign;
  String dateOfSign;
  Type type;
  List<Logs> logs;
  Employee employee;

  TimeOff(
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

  TimeOff.fromJson(Map<String, dynamic> json) {
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
    // if (json['childUnits'] != null) {
    //   childUnits = <Null>[];
    //   json['childUnits'].forEach((v) {
    //     childUnits.add(Null.fromJson(v));
    //   });
    // }
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
    // if (childUnits != null) {
    //   data['childUnits'] = childUnits.map((v) => v.toJson()).toList();
    // }
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
