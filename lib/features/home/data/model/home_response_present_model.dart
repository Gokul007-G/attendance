class HomeResponsePresentModel {
  String? date;
  String? inTime;
  String? outTime;

  HomeResponsePresentModel({this.date, this.inTime, this.outTime});

  HomeResponsePresentModel.fromJson(Map<String, dynamic> json) {
    date = json['attendance_date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_date'] = date;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    return data;
  }
}
