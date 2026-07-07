class HomeResponseMonthModel {
  int? workingDays;
  int? present;
  double? absent;
  int? late;
  int? permission;
  int? halfDay;

  HomeResponseMonthModel({
    this.workingDays,
    this.present,
    this.absent,
    this.late,
    this.permission,
    this.halfDay,
  });

  HomeResponseMonthModel.fromJson(Map<String, dynamic> json) {
    workingDays = (json['working_days'] as num?)?.toInt();
    present = (json['present_days'] as num?)?.toInt();
    absent = (json['absent_days'] as num?)?.toDouble();
    late = (json['lateCount'] as num?)?.toInt();
    permission = (json['permissionCount'] as num?)?.toInt();
    halfDay = (json['halfDayCount'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    return {
      'working_days': workingDays,
      'present_days': present,
      'absent_days': absent,
      'lateCount': late,
      'permissionCount': permission,
      'halfDayCount': halfDay,
    };
  }
}
