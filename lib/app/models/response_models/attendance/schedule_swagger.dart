class ScheduleGroupSwagger {
  double totalCounts;
  List<ScheduleGroup> data;

  ScheduleGroupSwagger({this.totalCounts, this.data});

  ScheduleGroupSwagger.fromJson(Map<String, dynamic> json) {
    totalCounts = json['totalCounts'];
    if (json['data'] != null) {
      data = <ScheduleGroup>[];
      json['data'].forEach((v) {
        data.add(ScheduleGroup.fromJson(v));
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

class ScheduleGroup {
  String id;
  String code;
  String name;
  Leader leader;
  List<Null> additionalLeaderIds;
  List<String> employeeIds;
  Null scheduleLoopConfigurationId;
  List<Null> scheduleLoops;

  ScheduleGroup(
      {this.id,
      this.code,
      this.name,
      this.leader,
      this.additionalLeaderIds,
      this.employeeIds,
      this.scheduleLoopConfigurationId,
      this.scheduleLoops});

  ScheduleGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    leader =
        json['leader'] != null ? Leader.fromJson(json['leader']) : null;
    if (json['additionalLeaderIds'] != null) {
      additionalLeaderIds = <Null>[];
      // json['additionalLeaderIds'].forEach((v) {
      //   additionalLeaderIds.add(Null.fromJson(v));
      // });
    }
    employeeIds = json['employeeIds'].cast<String>();
    scheduleLoopConfigurationId = json['scheduleLoopConfigurationId'];
    // if (json['scheduleLoops'] != null) {
    //   scheduleLoops = <Null>[];
    //   json['scheduleLoops'].forEach((v) {
    //     scheduleLoops.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    if (leader != null) {
      data['leader'] = leader.toJson();
    }
    // if (additionalLeaderIds != null) {
    //   data['additionalLeaderIds'] =
    //       additionalLeaderIds.map((v) => v.toJson()).toList();
    // }
    // data['employeeIds'] = employeeIds;
    // data['scheduleLoopConfigurationId'] = scheduleLoopConfigurationId;
    // if (scheduleLoops != null) {
    //   data['scheduleLoops'] =
    //       scheduleLoops.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Leader {
  String id;
  String code;
  String name;
  String positionId;
  String siteId;
  String unitId;
  String scheduleGroupId;

  Leader(
      {this.id,
      this.code,
      this.name,
      this.positionId,
      this.siteId,
      this.unitId,
      this.scheduleGroupId});

  Leader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
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
    data['positionId'] = positionId;
    data['siteId'] = siteId;
    data['unitId'] = unitId;
    data['scheduleGroupId'] = scheduleGroupId;
    return data;
  }
}
