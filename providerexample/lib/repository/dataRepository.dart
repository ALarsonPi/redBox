import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:providerexample/Models/HighScore.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('highScores');

  Stream<QuerySnapshot> getStream() {
    return collection.orderBy('score', descending: true).snapshots();
  }

  Future<DocumentReference> addHighScore(HighScore highScore) {
    return collection.add(highScore.toJson());
  }

  Future<int> findNumberOfScoresHigherThan(int currScore) async {
    int count = await collection
        .where('score', isGreaterThan: currScore)
        .orderBy('score', descending: true)
        .get()
        .then((value) => value.size);
    return count;
  }

  void updateHighScore(HighScore highScore) async {
    await collection.doc(highScore.referenceId).update(highScore.toJson());
  }

  void deleteHighScore(HighScore highScore) async {
    await collection.doc(highScore.referenceId).delete();
  }
}
