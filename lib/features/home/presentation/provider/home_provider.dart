import 'package:attendance/core/utils/logger.dart';
import 'package:attendance/features/home/data/model/home_response_model.dart';
import 'package:attendance/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  final HomeUsecase homeUsecase;
  final String userId;

  HomeResponseModel homeResponseModel = HomeResponseModel();

  bool _isLoading = false;
  String _error = "";
  bool result = false;

  bool get isLoading => _isLoading;
  String get error => _error;

  DateTime selectedDate = DateTime.now();

  HomeProvider({required this.homeUsecase, required this.userId}) {
    execute();
  }

  Future<bool> execute() async {
    _isLoading = true;
    notifyListeners();

    try {
      Log.i("-----------------Start Home Screen---------------------");

      homeResponseModel = await homeUsecase.call(
        userId,
        selectedDate.month,
        selectedDate.year,
      );

      Log.i("HomeProvider : Executed : ${homeResponseModel.toJson()}");

      result = homeResponseModel.status == true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      Log.e("HomeProvider : Catch : Error : $_error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    Log.i("-----------------End Home Screen---------------------");
    return result;
  }
}
