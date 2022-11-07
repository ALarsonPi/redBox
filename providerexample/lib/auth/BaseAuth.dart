import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(String email, String pasword);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  Future<String> signInWithGoogle();
}
