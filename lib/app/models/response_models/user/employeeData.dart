// ignore_for_file: file_names
// ignore_for_file: prefer_void_to_null

class EmployeeUserData {
  EmployeeData data;

  EmployeeUserData({this.data});

  EmployeeUserData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? EmployeeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class EmployeeData {
  String id;
  String code;
  String name;
  int gender;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String permanentAddress;
  String presentResidence;
  String ethnic;
  String nationality;
  String placeOfOrigin;
  String religion;
  String image;
  String imageRecognition;
  Null numberOfTax;
  bool isMarriaged;
  String dateJoined;
  int bonusType;
  IdentityCard identityCard;
  CitizenIdentification citizenIdentification;
  String socialInsuranceId;
  String healthInsuranceId;
  String certificateId;
  String positionId;
  String siteId;
  String unitId;
  String scheduleGroupId;
  bool isChoose;

  EmployeeData(
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

  EmployeeData.fromJson(Map<String, dynamic> json) {
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
    bonusType = json['bonusType'];
    identityCard = json['identityCard'] != null
        ? IdentityCard.fromJson(json['identityCard'])
        : null;
    citizenIdentification = json['citizenIdentification'] != null
        ? CitizenIdentification.fromJson(json['citizenIdentification'])
        : null;
    socialInsuranceId = json['socialInsuranceId'];
    healthInsuranceId = json['healthInsuranceId'];
    certificateId = json['certificateId'];
    positionId = json['positionId'];
    siteId = json['siteId'];
    unitId = json['unitId'];
    scheduleGroupId = json['scheduleGroupId'];
    isChoose = false;
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
    if (citizenIdentification != null) {
      data['citizenIdentification'] = citizenIdentification.toJson();
    }
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

class CitizenIdentification {
  String id;
  String number;
  String placeOfReleased;
  String dateReleased;
  String employeeId;

  CitizenIdentification(
      {this.id,
      this.number,
      this.placeOfReleased,
      this.dateReleased,
      this.employeeId});

  CitizenIdentification.fromJson(Map<String, dynamic> json) {
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
