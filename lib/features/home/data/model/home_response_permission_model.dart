/* This class to store Late || Permission || Half Day
≤ 9:15 AM → Normal (ignore / don’t store)
> 9:15 AM and ≤ 9:30 AM → Late
> 9:30 AM and ≤ 10:30 AM → Permission
> 10:30 AM → Half Day */

class HomeResponsePermissionModel {
  String? date;
  String? inTime;

  HomeResponsePermissionModel({this.date, this.inTime});

  HomeResponsePermissionModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    inTime = json['in_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['in_time'] = inTime;
    return data;
  }
}
