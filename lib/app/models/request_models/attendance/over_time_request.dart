class OverTimeRequest {
  int type;
  String factor;
  int workingHours;
  String timeBegin;
  String timeEnd;
  bool isAutomaticallyRegisterMeal;
  String id;

  OverTimeRequest(
      {this.type,
        this.factor,
        this.workingHours,
        this.id,
        this.timeBegin,
        this.timeEnd,
        this.isAutomaticallyRegisterMeal});

  OverTimeRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    factor = json['factor'];
    workingHours = json['workingHours'];
    timeBegin = json['timeBegin'];
    timeEnd = json['timeEnd'];
    isAutomaticallyRegisterMeal = json['isAutomaticallyRegisterMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['factor'] = factor;
    data['workingHours'] = workingHours;
    data['timeBegin'] = timeBegin;
    data['timeEnd'] = timeEnd;
    data['isAutomaticallyRegisterMeal'] = isAutomaticallyRegisterMeal;
    return data;
  }
}