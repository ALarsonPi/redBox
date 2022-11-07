import 'package:firebase_auth/firebase_auth.dart';
import 'package:providerexample/auth/BaseAuth.dart';

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

  @override
  Stream<String> get onAuthStateChanged => throw NullThrownError();

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String pasword) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
