// ignore_for_file: file_names

class MealSignUpRequest {
  String date;
  int shiftType;
  int mealType;
  List<String> employeeIds;

  MealSignUpRequest(
      {this.date, this.shiftType, this.mealType, this.employeeIds});

  MealSignUpRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (shiftType != null) {
      shiftType = json['shiftType'];
    }
    if (mealType != null) {
      mealType = json['mealType'];
    }

    employeeIds = json['employeeIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['shiftType'] = shiftType;
    data['mealType'] = mealType;
    data['employeeIds'] = employeeIds;
    return data;
  }
}
