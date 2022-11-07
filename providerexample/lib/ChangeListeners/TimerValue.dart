import 'package:flutter/material.dart';

class TimerValue extends ChangeNotifier {
  bool hasStarted = false;
  bool shouldStartCountdown = false;
  bool shouldShowEndScreen = false;
  TimerValue();

  startCountdown() {
    shouldStartCountdown = true;
    notifyListeners();
  }

  startGame() {
    hasStarted = true;
    notifyListeners();
  }

  endGame() {
    shouldShowEndScreen = true;
    shouldStartCountdown = false;
    hasStarted = false;
    shouldStartCountdown = true;
    notifyListeners();
  }

  restartGame() {
    shouldShowEndScreen = false;
    startCountdown();
  }
}
