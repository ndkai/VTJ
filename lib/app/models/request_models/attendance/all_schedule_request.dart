import 'create_shift_request.dart';

class OverallScheduleRequest {
  String fromDate;
  String toDate;
  List<int> daysOfWeek;
  String shiftId;
  List<String> employeeIds;
  OvertimeShift overtimeShift;

  OverallScheduleRequest(
      {this.fromDate,
        this.toDate,
        this.daysOfWeek,
        this.shiftId,
        this.employeeIds,
        this.overtimeShift});

  OverallScheduleRequest.fromJson(Map<String, dynamic> json) {
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    daysOfWeek = json['daysOfWeek'].cast<int>();
    if(shiftId != null){
      shiftId = json['shiftId'];
    }

    employeeIds = json['employeeIds'].cast<String>();
    overtimeShift = json['overtimeShift'] != null
        ? OvertimeShift.fromJson(json['overtimeShift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['daysOfWeek'] = daysOfWeek;
    data['shiftId'] = shiftId;
    data['employeeIds'] = employeeIds;
    if (overtimeShift != null) {
      data['overtimeShift'] = overtimeShift.toJson();
    }
    return data;
  }
}