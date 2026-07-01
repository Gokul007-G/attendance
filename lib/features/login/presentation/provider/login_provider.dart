import 'package:attendance/core/utils/local_data_store.dart';
import 'package:attendance/core/utils/logger.dart';
import 'package:attendance/features/login/data/model/login_response.dart';
import 'package:attendance/features/login/domain/usecase/login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUsecase loginUsecasel;
  bool _isLoading = false;
  String _error = "";

  bool get isLoading => _isLoading;
  String get error => _error;

  TextEditingController userIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var hasError = false;

  bool result = false;

  LoginResponse loginReponse = LoginResponse();

  LoginProvider({required this.loginUsecasel});

  @override
  void dispose() {
    userIdController.dispose();
    super.dispose();
  }

  void showError(bool value) {
    hasError = value;
    notifyListeners();
  }

  Future<bool> execute(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      loginReponse = await loginUsecasel.call(userId);

      Log.i(
        "LoginProvider : execute : loginReponse : ${loginReponse.toJson()}",
      );

      loginReponse.status == true ? result = true : result = false;

      if (loginReponse.status!) {
        HiveService.instance.setUserId(userId);
        HiveService.instance.setUserName(loginReponse.data!.name);
        HiveService.instance.setUserDept(loginReponse.data!.designation);
        HiveService.instance.setUserLocation(loginReponse.data!.location);
        HiveService.instance.setUserRole(loginReponse.data!.role);
      }


      _isLoading = false;

      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return result;
  }
}
