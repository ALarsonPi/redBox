import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HighScore {
  int score;
  String name;
  String? referenceId;
  HighScore({required this.score, required this.name, this.referenceId});

  Map<String, dynamic> toJson() => _highScoreToJson(this);

  factory HighScore.fromJson(Map<String, dynamic> json) =>
      _highScoreFromJson(json);

  factory HighScore.fromSnapshot(DocumentSnapshot snapshot) {
    final newHighScore =
        HighScore.fromJson(snapshot.data() as Map<String, dynamic>);
    newHighScore.referenceId = snapshot.reference.id;
    return newHighScore;
  }
}

HighScore _highScoreFromJson(Map<String, dynamic> json) {
  return HighScore(
    score: json['score'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _highScoreToJson(HighScore instance) => <String, dynamic>{
      'score': instance.score,
      'name': instance.name,
    };
