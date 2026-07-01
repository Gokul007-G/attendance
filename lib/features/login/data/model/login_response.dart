import 'package:attendance/features/login/data/model/login_response_user_data.dart';

class LoginResponse {
  String? message;
  bool? status;
  LoginResponseUserData? data;

  LoginResponse({this.message, this.status, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null
        ? LoginResponseUserData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['data'] = this.data?.toJson();
    return data;
  }
}
