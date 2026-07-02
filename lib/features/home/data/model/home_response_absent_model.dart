class HomeResponseAbsentModel {
  String? date;
  String? day;
  dynamic absentValue;

  HomeResponseAbsentModel({this.date, this.day, this.absentValue});

  HomeResponseAbsentModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    absentValue = json['absent_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['absent_value'] = absentValue;
    return data;
  }
}
