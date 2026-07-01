import 'package:flutter/cupertino.dart';

class Log {
  static void i(dynamic data, {StackTrace? stackTrace}) {
    debugPrint("$data");
  }

  static void d(dynamic data, {StackTrace? stackTrace}) {
    debugPrint("$data$stackTrace");
  }

  static void e(dynamic data, {StackTrace? stackTrace}) {
    debugPrint("$data$stackTrace");
  }
}
