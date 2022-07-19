// ignore_for_file: prefer_void_to_null

class EmployeeSwagger {
  List<Data> data;

  EmployeeSwagger({this.data});

  EmployeeSwagger.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
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

class Data {
  String id;
  String code;
  String name;
  int gender;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String permanentAddress;
  String presentResidence;
  Null ethnic;
  String nationality;
  Null placeOfOrigin;
  Null religion;
  Null image;
  String imageRecognition;
  Null numberOfTax;
  bool isMarriaged;
  String dateJoined;
  int bonusType;
  IdentityCard identityCard;
  Null citizenIdentification;
  Null socialInsuranceId;
  Null healthInsuranceId;
  Null certificateId;
  String positionId;
  String siteId;
  String unitId;
  String scheduleGroupId;

  Data(
      {this.id,
        this.code,
        this.name,
        this.gender,
        this.dateOfBirth,
        this.phoneNumber,
        this.email,
        this.permanentAddress,
        this.presentResidence,
        this.ethnic,
        this.nationality,
        this.placeOfOrigin,
        this.religion,
        this.image,
        this.imageRecognition,
        this.numberOfTax,
        this.isMarriaged,
        this.dateJoined,
        this.bonusType,
        this.identityCard,
        this.citizenIdentification,
        this.socialInsuranceId,
        this.healthInsuranceId,
        this.certificateId,
        this.positionId,
        this.siteId,
        this.unitId,
        this.scheduleGroupId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    permanentAddress = json['permanentAddress'];
    presentResidence = json['presentResidence'];
    ethnic = json['ethnic'];
    nationality = json['nationality'];
    placeOfOrigin = json['placeOfOrigin'];
    religion = json['religion'];
    image = json['image'];
    imageRecognition = json['imageRecognition'];
    numberOfTax = json['numberOfTax'];
    isMarriaged = json['isMarriaged'];
    dateJoined = json['dateJoined'];
    // bonusType = json['bonusType'];
    identityCard = json['identityCard'] != null
        ? IdentityCard.fromJson(json['identityCard'])
        : null;
    citizenIdentification = json['citizenIdentification'];
    socialInsuranceId = json['socialInsuranceId'];
    healthInsuranceId = json['healthInsuranceId'];
    certificateId = json['certificateId'];
    positionId = json['positionId'];
    siteId = json['siteId'];
    unitId = json['unitId'];
    scheduleGroupId = json['scheduleGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['permanentAddress'] = permanentAddress;
    data['presentResidence'] = presentResidence;
    data['ethnic'] = ethnic;
    data['nationality'] = nationality;
    data['placeOfOrigin'] = placeOfOrigin;
    data['religion'] = religion;
    data['image'] = image;
    data['imageRecognition'] = imageRecognition;
    data['numberOfTax'] = numberOfTax;
    data['isMarriaged'] = isMarriaged;
    data['dateJoined'] = dateJoined;
    data['bonusType'] = bonusType;
    if (identityCard != null) {
      data['identityCard'] = identityCard.toJson();
    }
    data['citizenIdentification'] = citizenIdentification;
    data['socialInsuranceId'] = socialInsuranceId;
    data['healthInsuranceId'] = healthInsuranceId;
    data['certificateId'] = certificateId;
    data['positionId'] = positionId;
    data['siteId'] = siteId;
    data['unitId'] = unitId;
    data['scheduleGroupId'] = scheduleGroupId;
    return data;
  }
}

class IdentityCard {
  String id;
  String number;
  String placeOfReleased;
  String dateReleased;
  String employeeId;

  IdentityCard(
      {this.id,
        this.number,
        this.placeOfReleased,
        this.dateReleased,
        this.employeeId});

  IdentityCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    placeOfReleased = json['placeOfReleased'];
    dateReleased = json['dateReleased'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['placeOfReleased'] = placeOfReleased;
    data['dateReleased'] = dateReleased;
    data['employeeId'] = employeeId;
    return data;
  }
}