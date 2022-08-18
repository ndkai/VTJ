class MealBatchRequest {
  String date;
  List<String> employeeIds;

  MealBatchRequest(
      {this.date, this.employeeIds});

  MealBatchRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];

    employeeIds = json['employeeIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['employeeIds'] = employeeIds;
    return data;
  }
}
