class MealOverView {
  double totalCounts;
  List<MealOverViewData> data;

  MealOverView({this.totalCounts, this.data});

  MealOverView.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <MealOverViewData>[];
      json['data'].forEach((v) {
        data.add(MealOverViewData.fromJson(v));
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

class MealOverViewData {
  Employee employee;
  bool isChoose;
  List<Meals> meals;

  MealOverViewData({this.employee, this.meals, this.isChoose = false});

  MealOverViewData.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals.add(Meals.fromJson(v));
      });
    }
    isChoose = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['employee'] = employee.toJson();
    }
    if (meals != null) {
      data['meals'] = meals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employee {
  String id;
  String code;
  String name;
  String image;
  String positionId;
  String siteId;
  String unitId;
  String scheduleGroupId;

  Employee(
      {this.id,
        this.code,
        this.name,
        this.image,
        this.positionId,
        this.siteId,
        this.unitId,
        this.scheduleGroupId});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    positionId = json['positionId'];
    siteId = json['siteId'];
    image = json['image'];
    unitId = json['unitId'];
    scheduleGroupId = json['scheduleGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['image'] = image;
    data['positionId'] = positionId;
    data['siteId'] = siteId;
    data['unitId'] = unitId;
    data['scheduleGroupId'] = scheduleGroupId;
    return data;
  }
}

class Meals {
  String id;
  String date;
  int mealType;
  int shiftType;
  bool isConfirmed;

  Meals({this.id, this.date, this.mealType, this.shiftType, this.isConfirmed});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    mealType = json['mealType'];
    shiftType = json['shiftType'];
    isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['mealType'] = mealType;
    data['shiftType'] = shiftType;
    data['isConfirmed'] = isConfirmed;
    return data;
  }
}