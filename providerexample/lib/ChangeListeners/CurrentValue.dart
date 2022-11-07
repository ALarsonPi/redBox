import 'package:flutter/material.dart';
import 'dart:math';

class CurrentValue extends ChangeNotifier {
  int currValue = 1;
  int currRow = 1;
  int size = 10;
  int numRows = 2;

  void pickNewValue() {
    currValue = Random().nextInt(size);
    currRow = Random().nextInt(numRows);
    notifyListeners();
  }

  void incrementSize() {
    size++;
    notifyListeners();
  }

  void incrementNumRows() {
    numRows++;
    notifyListeners();
  }

  void resetValue() {
    currValue = 1;
    currRow = 1;
    size = 10;
    numRows = 2;
    notifyListeners();
  }
}
