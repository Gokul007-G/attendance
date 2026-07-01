class HomeResponseMonthModel {
  int? persent;
  int? absent;
  int? late;
  int? permission;
  int? workingDays;

  HomeResponseMonthModel({
    this.persent,
    this.absent,
    this.late,
    this.permission,
    this.workingDays,
  });

  HomeResponseMonthModel.fromJson(Map<String, dynamic> json) {
    persent = json['present_days'];
    absent = json['absent_days'];
    late = json['lateCount'];
    permission = json['permission'];
    workingDays = json['full_working_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present_days'] = persent;
    data['absent_days'] = absent;
    data['lateCount'] = late;
    data['permission'] = permission;
    data['full_working_days'] = workingDays;

    return data;
  }
}
