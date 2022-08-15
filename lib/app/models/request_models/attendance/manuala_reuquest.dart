class EmployeeManualRequest {
  String employeeId;
  String note;
  String checkIn;
  String checkOut;

  EmployeeManualRequest({this.employeeId, this.note, this.checkIn, this.checkOut});

  EmployeeManualRequest.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    note = json['note'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['note'] = note;
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    return data;
  }
}