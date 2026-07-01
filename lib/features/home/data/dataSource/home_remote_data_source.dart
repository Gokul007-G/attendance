import 'package:attendance/features/home/data/model/home_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeResponseModel> fetchHomeResult(String userId, int month, int year);
}
