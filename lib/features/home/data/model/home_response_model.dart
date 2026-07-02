import 'package:attendance/features/home/data/model/home_response_absent_model.dart';
import 'package:attendance/features/home/data/model/home_response_half_model.dart';
import 'package:attendance/features/home/data/model/home_response_month_model.dart';
import 'package:attendance/features/home/data/model/home_response_late_model.dart';
import 'package:attendance/features/home/data/model/home_response_permission_model.dart';
import 'package:attendance/features/home/data/model/home_response_present_model.dart';
import 'package:attendance/features/home/data/model/home_response_punch_model.dart';
import 'package:attendance/features/home/data/model/home_response_today_model.dart';

class HomeResponseModel {
  String? message;
  bool? status;
  HomeResponseTodayModel? todayData;
  HomeResponseMonthModel? monthData;
  List<HomeResponsePunchModel>? punchData;
  List<HomeResponsePresentModel>? presentData;
  List<HomeResponseAbsentModel>? absentData;
  List<HomeResponsePermissionModel>? permissionData;
  List<HomeResponseLateModel>? lateData;
  List<HomeResponseHalfModel>? halfData;

  HomeResponseModel({
    this.message,
    this.status,
    this.todayData,
    this.monthData,
    this.punchData,
    this.presentData,
    this.absentData,
    this.permissionData,
    this.lateData,
    this.halfData,
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
    presentData = json['presentDataList'] != null
        ? (json['presentDataList'] as List)
              .map((e) => HomeResponsePresentModel.fromJson(e))
              .toList()
        : null;
    absentData = json['absentDaysList'] != null
        ? (json['absentDaysList'] as List)
              .map((e) => HomeResponseAbsentModel.fromJson(e))
              .toList()
        : null;
    permissionData = json['permissionList'] != null
        ? (json['permissionList'] as List)
              .map((e) => HomeResponsePermissionModel.fromJson(e))
              .toList()
        : null;

    lateData = json['lateDaysList'] != null
        ? (json['lateDaysList'] as List)
              .map((e) => HomeResponseLateModel.fromJson(e))
              .toList()
        : null;

    halfData = json['halfDayList'] != null
        ? (json['halfDayList'] as List)
              .map((e) => HomeResponseHalfModel.fromJson(e))
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
    data['presentDataList'] = presentData?.map((e) => e.toJson()).toList();
    data['absentDaysList'] = absentData?.map((e) => e.toJson()).toList();
    data['permissionList'] = permissionData?.map((e) => e.toJson()).toList();
    data['lateDaysList'] = lateData?.map((e) => e.toJson()).toList();
    data['halfDayList'] = halfData?.map((e) => e.toJson()).toList();

    return data;
  }
}
