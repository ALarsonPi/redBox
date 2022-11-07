import 'package:flutter/cupertino.dart';

class Points extends ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void resetPoints() {
    value = 0;
    notifyListeners();
  }
}
