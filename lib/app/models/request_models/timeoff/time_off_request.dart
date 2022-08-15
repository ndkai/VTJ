class PostTimeOffRequest {
  String employeeId;
  String timeOffTypeId;
  String fromDate;
  String toDate;
  bool isAbsenteeism;
  String note;
  String sign;

  PostTimeOffRequest(
      {this.employeeId,
      this.timeOffTypeId,
      this.fromDate,
      this.toDate,
      this.isAbsenteeism,
      this.note,
      this.sign});

  PostTimeOffRequest.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    timeOffTypeId = json['timeOffTypeId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    isAbsenteeism = json['isAbsenteeism'];
    note = json['note'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['timeOffTypeId'] = timeOffTypeId;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['isAbsenteeism'] = isAbsenteeism;
    data['note'] = note;
    data['sign'] = sign;
    return data;
  }
}
