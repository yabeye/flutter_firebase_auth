import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  bool _isLoading;

  AuthProvider(this._firebaseAuth, this._isLoading);

  bool get isLoading => _isLoading;
  User? get getCurrentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  // setters!
  set isLoading(value) => _isLoading = value;

  Future<bool> signUp({String? email, String? password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<bool> logIn({String? email, String? password}) async {
    isLoading = true;
    try {
      Future.delayed(
          const Duration(seconds: 4), () => {debugPrint("Done Wating")});
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      isLoading = false;
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
