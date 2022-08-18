class MealRequest{
  final String scheduleGroupId;
  final String date;

  MealRequest({this.scheduleGroupId, this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['scheduleGroupId'] = scheduleGroupId;
    return data;
  }
}