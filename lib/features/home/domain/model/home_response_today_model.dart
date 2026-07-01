class HomeResponseTodayModel {
  String? inTime;
  String? outTime;
  String? workingHours;

  HomeResponseTodayModel({this.inTime, this.outTime, this.workingHours});

  HomeResponseTodayModel.fromJson(Map<String, dynamic> json) {
    inTime = json['in_time'];
    outTime = json['out_time'];
    workingHours = json['working_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['working_hours'] = workingHours;

    return data;
  }
}
