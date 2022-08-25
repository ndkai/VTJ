class BatchForAnonymousRequest {
  String date;
  String unitId;
  List<Meall> meals;

  BatchForAnonymousRequest({this.date, this.unitId, this.meals});

  BatchForAnonymousRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    unitId = json['unitId'];
    if (json['meals'] != null) {
      meals = <Meall>[];
      json['meals'].forEach((v) {
        meals.add(Meall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['unitId'] = unitId;
    if (meals != null) {
      data['meals'] = meals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meall {
  int shiftType;
  int mealType;
  int total;
  String id;

  Meall({this.shiftType, this.mealType, this.total, this.id});

  Meall.fromJson(Map<String, dynamic> json) {
    shiftType = json['shiftType'];
    mealType = json['mealType'];
    total = json['total'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shiftType'] = shiftType;
    data['mealType'] = mealType;
    data['total'] = total;
    data['id'] = id;
    return data;
  }
}
