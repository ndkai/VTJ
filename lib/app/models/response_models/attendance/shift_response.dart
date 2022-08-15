class ShiftResponse {
  double totalCounts;
  List<ShiftData> data;

  ShiftResponse({this.totalCounts, this.data});

  ShiftResponse.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <ShiftData>[];
      json['data'].forEach((v) {
        data.add(ShiftData.fromJson(v));
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

class ShiftData {
  String id;
  String code;
  String name;
  String colour;
  List<int> types;
  List<LimitedFactors> limitedFactors;
  bool isPeriodLock;
  String timeBegin;
  String timeEnd;
  double workingHours;
  double shortBreakingHours;
  double longBreakingHours;
  String shiftDetails;

  ShiftData(
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

  ShiftData.fromJson(Map<String, dynamic> json) {
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
  double factor;
  double hour;

  LimitedFactors({this.factor, this.hour});

  LimitedFactors.fromJson(Map<String, dynamic> json) {
    factor = json['factor'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['factor'] = factor;
    data['hour'] = hour;
    return data;
  }
}