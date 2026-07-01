import 'package:attendance/features/home/data/dataSource/home_remote_data_source_impl.dart';
import 'package:attendance/features/home/data/model/home_response_model.dart';
import 'package:attendance/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRemoteDataSourceImpl homeRemoteDataSourceImpl;

  HomeRepositoryImpl({required this.homeRemoteDataSourceImpl});

  @override
  Future<HomeResponseModel> getHomeResult(
    String userId,
    int month,
    int year,
  ) async {
    return homeRemoteDataSourceImpl.fetchHomeResult(userId, month, year);
  }
}
