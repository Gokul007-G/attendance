import 'package:attendance/features/home/data/model/home_response_month_model.dart';
import 'package:attendance/features/home/data/model/home_response_punch_model.dart';
import 'package:attendance/features/home/data/model/home_response_today_model.dart';

class HomeResponseModel {
  String? message;
  bool? status;
  HomeResponseTodayModel? todayData;
  HomeResponseMonthModel? monthData;
  List<HomeResponsePunchModel>? punchData;

  HomeResponseModel({
    this.message,
    this.status,
    this.todayData,
    this.monthData,
    this.punchData,
  });

  HomeResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    todayData = json['todayData'] != null
        ? HomeResponseTodayModel.fromJson(json['todayData'])
        : null;
    monthData = json['monthData'] != null
        ? HomeResponseMonthModel.fromJson(json['monthData'])
        : null;
    punchData = json['punchRecords'] != null
        ? (json['punchRecords'] as List)
              .map((e) => HomeResponsePunchModel.fromJson(e))
              .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['todayData'] = todayData?.toJson();
    data['monthData'] = monthData?.toJson();
    data['punchRecords'] = punchData?.map((e) => e.toJson()).toList();

    return data;
  }
}
