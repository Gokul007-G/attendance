import 'package:attendance/features/login/data/model/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> getLoginResult(String userId);
}
