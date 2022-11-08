import 'package:cloud_firestore/cloud_firestore.dart';
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

  void updateHighScore(HighScore highScore) async {
    await collection.doc(highScore.referenceId).update(highScore.toJson());
  }

  void deleteHighScore(HighScore highScore) async {
    await collection.doc(highScore.referenceId).delete();
  }
}
