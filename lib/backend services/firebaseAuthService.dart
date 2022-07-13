import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
}

  Future<String?> signIn({String? email, String? password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
      return "Signed In";
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String?> signUp({String? email, String? password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
      return "Signed Up";
    }
    on FirebaseAuthException catch (e){
      return e.message;
    }
  }

}