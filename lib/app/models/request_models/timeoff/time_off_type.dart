class TimeOffType {
  double totalCounts;
  List<TimeOffTypeData> data;

  TimeOffType({this.totalCounts, this.data});

  TimeOffType.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <TimeOffTypeData>[];
      json['data'].forEach((v) {
        data.add(TimeOffTypeData.fromJson(v));
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

class TimeOffTypeData {
  String id;
  String abbreviation;
  String description;
  int amount;
  double factor;
  bool isCalculatedAttendance;

  TimeOffTypeData(
      {this.id,
        this.abbreviation,
        this.description,
        this.amount,
        this.factor,
        this.isCalculatedAttendance});

  TimeOffTypeData.fromJson(Map<String, dynamic> json) {
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