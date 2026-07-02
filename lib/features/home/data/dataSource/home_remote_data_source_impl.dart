import 'package:attendance/core/utils/logger.dart';
import 'package:attendance/features/home/data/dataSource/home_remote_data_source.dart';
import 'package:attendance/features/home/data/model/home_response_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<HomeResponseModel> fetchHomeResult(
    String userId,
    int month,
    int year,
  ) async {
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
      Log.i('UserId : $userId');
      final homeResponse = await dio.post(
        'home_screen.php',
        data: {'userId': userId, 'month': month, 'year': year},
      );

      Log.i(
        "HomeRemoteDataSourceImpl : StatusCode :: ${homeResponse.statusCode}",
      );

      if (homeResponse.statusCode == 200) {
        dynamic response = homeResponse.data;

        Log.i("HomeRemoteDataSourceImpl : HTTP : Response : $response");

        HomeResponseModel homeResponseResult = HomeResponseModel.fromJson(
          response,
        );

        return homeResponseResult;
      } else {
        Log.e("HomeRemoteDataSourceImpl :: Unable to load the data");
        throw Exception();
      }
    } catch (e) {
      Log.e("HomeRemoteDataSourceImpl Error : ${e.toString()}");
      throw Exception("Some think Went Wrong! : ${e.toString()}");
    }
  }
}
