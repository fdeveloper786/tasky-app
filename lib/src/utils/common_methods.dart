import 'package:flutter/foundation.dart';

void printDebug(String message) {
  assert(() {
    if (kDebugMode) {
      print(message);
    }
    return true;
  }());
}
