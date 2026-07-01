import 'package:attendance/features/home/data/model/home_response_model.dart';
import 'package:attendance/features/home/domain/repositories/home_repository.dart';

class HomeUsecase {
  HomeRepository homeRepository;

  HomeUsecase({required this.homeRepository});

  Future<HomeResponseModel> call(String userId, int month, int year) {
    return homeRepository.getHomeResult(userId, month, year);
  }
}
