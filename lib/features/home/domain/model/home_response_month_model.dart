class HomeResponseMonthModel {
  String? persent;
  String? absent;
  String? late;
  String? permission;

  HomeResponseMonthModel({
    this.persent,
    this.absent,
    this.late,
    this.permission,
  });

  HomeResponseMonthModel.fromJson(Map<String, dynamic> json) {
    persent = json['persent'];
    absent = json['absent'];
    late = json['late'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['persent'] = persent;
    data['absent'] = absent;
    data['late'] = late;
    data['permission'] = permission;

    return data;
  }
}
