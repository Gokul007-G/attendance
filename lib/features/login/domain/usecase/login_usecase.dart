import 'package:attendance/features/login/data/model/login_response.dart';
import 'package:attendance/features/login/domain/repositories/login_repository.dart';

class LoginUsecase {
  LoginRepository loginRepository;

  LoginUsecase({required this.loginRepository});

  Future<LoginResponse> call(String userId) {
    return loginRepository.getLoginResult(userId);
  }
}
