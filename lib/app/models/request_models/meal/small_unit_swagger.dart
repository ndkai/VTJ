class SmallUnitSwagger {
  double totalCounts;
  List<SmallUnit> data;

  SmallUnitSwagger({this.totalCounts, this.data});

  SmallUnitSwagger.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <SmallUnit>[];
      json['data'].forEach((v) {
        data.add(SmallUnit.fromJson(v));
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

class SmallUnit {
  String id;
  String code;
  String name;
  int type;
  int prescribedPersonnel;
  int actualPersonnel;
  int unitPriceOfMeal;

  SmallUnit({
    this.id,
    this.code,
    this.name,
    this.type,
    this.prescribedPersonnel,
    this.actualPersonnel,
    this.unitPriceOfMeal,
  });

  SmallUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    prescribedPersonnel = json['prescribedPersonnel'];
    actualPersonnel = json['actualPersonnel'];
    unitPriceOfMeal = json['unitPriceOfMeal'];
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
    return data;
  }
}
