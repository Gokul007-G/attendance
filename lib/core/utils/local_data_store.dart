import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static final HiveService instance = HiveService();

  late Box box;

  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('appBox');
  }

  //userID
  Future<void> setUserId(dynamic userId) async {
    await box.put('userId', userId);
  }

  dynamic getUserId() {
    return box.get('userId');
  }

  //userName
  Future<void> setUserName(dynamic userName) async {
    await box.put('userName', userName);
  }

  dynamic getUserName() {
    return box.get('userName');
  }

  //Department
  Future<void> setUserDept(dynamic userDetp) async {
    await box.put('userDept', userDetp);
  }

  dynamic getUserDept() {
    return box.get('userDept');
  }

  //Location
  Future<void> setUserLocation(dynamic userLocation) async {
    await box.put('userLocation', userLocation);
  }

  dynamic getUserLocation() {
    return box.get('userLocation') == '' ? 'Guindy' : box.get('userLocation');
  }

  //Role
  Future<void> setUserRole(dynamic userRole) async {
    await box.put('userRole', userRole);
  }

  dynamic getUserRole() {
    return box.get('userRole');
  }
}
