class GetEmployeeRequest {
  int pageIndex;
  int pageSize;
  String keyword;

  GetEmployeeRequest({this.pageIndex = 0, this.pageSize = 100000, this.keyword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['keyword'] = keyword;
    return data;
  }
}
