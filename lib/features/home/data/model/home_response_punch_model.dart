class HomeResponsePunchModel {
  int? sno;
  int? punchId;
  String? date;

  HomeResponsePunchModel({this.sno, this.punchId, this.date});

  HomeResponsePunchModel.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    punchId = json['PunchTimeDetailsId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sno'] = sno;
    data['PunchTimeDetailsId'] = punchId;
    data['date'] = date;

    return data;
  }
}
