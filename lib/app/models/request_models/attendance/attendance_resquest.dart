class AttendanceRequest{
  final String fromDate;
  final String toDate;
  final String id;

  AttendanceRequest({this.fromDate, this.toDate, this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['id'] = id;
    return data;
  }
}