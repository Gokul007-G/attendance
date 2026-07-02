class HomeResponseMonthModel {
  int? workingDays;
  int? persent;
  int? absent;
  int? late;
  int? permission;
  int? halfDay;

  HomeResponseMonthModel({
    this.workingDays,
    this.persent,
    this.absent,
    this.late,
    this.permission,
    this.halfDay,
  });

  HomeResponseMonthModel.fromJson(Map<String, dynamic> json) {
    persent = json['present_days'];
    absent = json['absent_days'];
    late = json['lateCount'];
    permission = json['permissionCount'];
    workingDays = json['working_days'];
    halfDay = json['halfDayCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present_days'] = persent;
    data['absent_days'] = absent;
    data['lateCount'] = late;
    data['permissionCount'] = permission;
    data['working_days'] = workingDays;
    data['halfDayCount'] = halfDay;

    return data;
  }
}
