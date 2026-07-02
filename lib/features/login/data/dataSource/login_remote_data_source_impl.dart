import 'package:attendance/core/utils/logger.dart';
import 'package:attendance/features/login/data/dataSource/login_remote_data_source.dart';
import 'package:attendance/features/login/data/model/login_response.dart';
import 'package:dio/dio.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<LoginResponse> fetchLoginResult(String userId) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.195/bb-AMS/mobile_services/",
        // baseUrl: "http://10.0.2.2/bb-AMS/mobile_services/",
        headers: {"Content-Type": "application/json"},
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
      ),
    );

    try {
      Log.i("userId : $userId");
      final loginResponse = await dio.post(
        "login.php",
        data: {"userId": userId},
      );
      Log.i("userId Print : $userId");

      Log.i(
        "LoginRemoteDataSourceImpl : HTTP : Status Code : ${loginResponse.statusCode}",
      );

      if (loginResponse.statusCode == 200) {
        dynamic response = loginResponse.data;

        Log.i("LoginRemoteDataSourceImpl : HTTP : Response : $response");

        Map<String, dynamic> responseData = Map<String, dynamic>.from(response);

        LoginResponse loginRepositoriesResult = LoginResponse.fromJson(
          responseData,
        );

        return loginRepositoriesResult;
      } else {
        Log.i(
          "LoginRemoteDataSourceImpl : HTTP : Status Code : ${loginResponse.statusCode}",
        );

        Log.i("LoginRemoteDataSourceImpl : Unable to load login data");
        throw Exception();
      }
    } catch (e) {
      Log.e("LoginRemoteDataSourceImpl Error: ${e.toString()}");
      throw Exception('Some thing Went Wrong! : ${e.toString()}');
    }
  }
}
