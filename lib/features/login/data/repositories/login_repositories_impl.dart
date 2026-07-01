import 'package:attendance/features/login/data/dataSource/login_remote_data_source_impl.dart';
import 'package:attendance/features/login/data/model/login_response.dart';
import 'package:attendance/features/login/domain/repositories/login_repository.dart';

class LoginRepositoriesImpl extends LoginRepository {
  LoginRemoteDataSourceImpl loginRemoteDataSourceImpl;

  LoginRepositoriesImpl({required this.loginRemoteDataSourceImpl});

  @override
  Future<LoginResponse> getLoginResult(String userId) {
    return loginRemoteDataSourceImpl.fetchLoginResult(userId);
  }
}
