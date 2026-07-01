import 'package:attendance/features/home/data/model/home_response_model.dart';

abstract class HomeRepository {
  Future<HomeResponseModel> getHomeResult(String userId, int month, int year);
}
