class ServiceModel {
  String dateCreated;
  String dateUpdated;
  String id;
  String description;
  String name;
  int price;
  String code;
  bool isChoose;

  ServiceModel(
      {this.dateCreated,
        this.dateUpdated,
        this.id,
        this.price = 275000,
        this.code,
        this.description,
        this.name});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    code = json['code'];
    dateUpdated = json['dateUpdated'];
    id = json['id'];
    description = json['description'];
    price = json['price'];
    name = json['name'];
    isChoose = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['id'] = id;
    data['description'] = description;
    data['name'] = name;
    return data;
  }
}