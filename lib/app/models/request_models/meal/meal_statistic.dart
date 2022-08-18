class MealStatistic {
  bool succeed;
  MealStatisticSwaggerData data;

  MealStatistic({this.succeed, this.data});

  MealStatistic.fromJson(Map<String, dynamic> json) {
    succeed = json['succeed'];
    data = json['data'] != null ? MealStatisticSwaggerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succeed'] = succeed;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MealStatisticSwaggerData {
  List<MealStatisticData> data;

  MealStatisticSwaggerData({this.data});

  MealStatisticSwaggerData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MealStatisticData>[];
      json['data'].forEach((v) {
        data.add(MealStatisticData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealStatisticData {
  Unit unit;
  List<ChildUnits> childUnits;
  int registeredEmployeeTotal;
  Estimate estimate;
  Estimate actual;

  MealStatisticData(
      {this.unit,
        this.childUnits,
        this.registeredEmployeeTotal,
        this.estimate,
        this.actual});

  MealStatisticData.fromJson(Map<String, dynamic> json) {
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['childUnits'] != null) {
      childUnits = <ChildUnits>[];
      json['childUnits'].forEach((v) {
        childUnits.add(ChildUnits.fromJson(v));
      });
    }
    registeredEmployeeTotal = json['registeredEmployeeTotal'];
    estimate = json['estimate'] != null
        ? Estimate.fromJson(json['estimate'])
        : null;
    actual =
    json['actual'] != null ? Estimate.fromJson(json['actual']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (unit != null) {
      data['unit'] = unit.toJson();
    }
    if (childUnits != null) {
      data['childUnits'] = childUnits.map((v) => v.toJson()).toList();
    }
    data['registeredEmployeeTotal'] = registeredEmployeeTotal;
    if (estimate != null) {
      data['estimate'] = estimate.toJson();
    }
    if (actual != null) {
      data['actual'] = actual.toJson();
    }
    return data;
  }
}

class Unit {
  String id;
  String code;
  String name;
  int type;
  int prescribedPersonnel;
  int actualPersonnel;
  int unitPriceOfMeal;
  List<ChildUnits> childUnits;

  Unit(
      {this.id,
        this.code,
        this.name,
        this.type,
        this.prescribedPersonnel,
        this.actualPersonnel,
        this.unitPriceOfMeal,
        this.childUnits});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    prescribedPersonnel = json['prescribedPersonnel'];
    actualPersonnel = json['actualPersonnel'];
    unitPriceOfMeal = json['unitPriceOfMeal'];
    if (json['childUnits'] != null) {
      childUnits = <ChildUnits>[];
      json['childUnits'].forEach((v) {
        childUnits.add(ChildUnits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['type'] = type;
    data['prescribedPersonnel'] = prescribedPersonnel;
    data['actualPersonnel'] = actualPersonnel;
    data['unitPriceOfMeal'] = unitPriceOfMeal;
    if (childUnits != null) {
      data['childUnits'] = childUnits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildUnits {
  Unit unit;
  int registeredEmployeeTotal;
  Estimate estimate;
  Estimate actual;

  ChildUnits(
      {this.unit,
        this.registeredEmployeeTotal,
        this.estimate,
        this.actual});

  ChildUnits.fromJson(Map<String, dynamic> json) {
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    // if (json['childUnits'] != null) {
    //   childUnits = <Null>[];
    //   json['childUnits'].forEach((v) {
    //     childUnits.add(Null.fromJson(v));
    //   });
    // }
    registeredEmployeeTotal = json['registeredEmployeeTotal'];
    estimate = json['estimate'] != null
        ? Estimate.fromJson(json['estimate'])
        : null;
    actual =
    json['actual'] != null ? Estimate.fromJson(json['actual']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (unit != null) {
      data['unit'] = unit.toJson();
    }
    data['registeredEmployeeTotal'] = registeredEmployeeTotal;
    if (estimate != null) {
      data['estimate'] = estimate.toJson();
    }
    if (actual != null) {
      data['actual'] = actual.toJson();
    }
    return data;
  }
}

class Estimate {
  NormalShift normalShift;
  NormalShift nightShift;
  NormalShift overtimeDayShift;
  NormalShift overtimeNightShift;

  Estimate(
      {this.normalShift,
        this.nightShift,
        this.overtimeDayShift,
        this.overtimeNightShift});

  Estimate.fromJson(Map<String, dynamic> json) {
    normalShift = json['normalShift'] != null
        ? NormalShift.fromJson(json['normalShift'])
        : null;
    nightShift = json['nightShift'] != null
        ? NormalShift.fromJson(json['nightShift'])
        : null;
    overtimeDayShift = json['overtimeDayShift'] != null
        ? NormalShift.fromJson(json['overtimeDayShift'])
        : null;
    overtimeNightShift = json['overtimeNightShift'] != null
        ? NormalShift.fromJson(json['overtimeNightShift'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (normalShift != null) {
      data['normalShift'] = normalShift.toJson();
    }
    if (nightShift != null) {
      data['nightShift'] = nightShift.toJson();
    }
    if (overtimeDayShift != null) {
      data['overtimeDayShift'] = overtimeDayShift.toJson();
    }
    if (overtimeNightShift != null) {
      data['overtimeNightShift'] = overtimeNightShift.toJson();
    }
    return data;
  }
}

class NormalShift {
  int carnivore;
  int vegetarian;

  NormalShift({this.carnivore, this.vegetarian});

  NormalShift.fromJson(Map<String, dynamic> json) {
    carnivore = json['carnivore'];
    vegetarian = json['vegetarian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carnivore'] = carnivore;
    data['vegetarian'] = vegetarian;
    return data;
  }
}