class CreateScheduleRequest {
  String date;
  String employeeId;
  String shiftId;
  OvertimeShift overtimeShift;

  CreateScheduleRequest(
      {this.date, this.employeeId, this.shiftId, this.overtimeShift});

  CreateScheduleRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    employeeId = json['employeeId'];
    shiftId = json['shiftId'];
    overtimeShift = json['overtimeShift'] != null
        ? OvertimeShift.fromJson(json['overtimeShift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['employeeId'] = employeeId;
    data['shiftId'] = shiftId;
    if (overtimeShift != null) {
      data['overtimeShift'] = overtimeShift.toJson();
    }
    return data;
  }
}

class OvertimeShift {
  int type;
  int workingHours;
  String factor;
  String timeBegin;
  String timeEnd;
  bool isAutomaticallyRegisterMeal;

  OvertimeShift(
      {this.type,
        this.workingHours,
        this.factor,
        this.timeBegin,
        this.timeEnd,
        this.isAutomaticallyRegisterMeal});

  OvertimeShift.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    workingHours = json['workingHours'];
    factor = json['factor'];
    timeBegin = json['timeBegin'];
    timeEnd = json['timeEnd'];
    isAutomaticallyRegisterMeal = json['isAutomaticallyRegisterMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['workingHours'] = workingHours;
    data['factor'] = factor;
    data['timeBegin'] = timeBegin;
    data['timeEnd'] = timeEnd;
    data['isAutomaticallyRegisterMeal'] = isAutomaticallyRegisterMeal;
    return data;
  }
}