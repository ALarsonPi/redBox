import 'package:flutter/material.dart';

class HighScore {
  HighScore({required this.score, required this.name});

  int score;
  String name;
}

class HighScoreNotifier extends ChangeNotifier {}
