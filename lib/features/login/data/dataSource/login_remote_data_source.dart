import 'package:attendance/features/login/data/model/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> fetchLoginResult(String userId);
}
