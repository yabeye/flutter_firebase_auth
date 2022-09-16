import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isAuthLoading = false;
  get isAuthLoading => _isAuthLoading;
  setIsAuthLoading(bool value) {
    _isAuthLoading = value;
    notifyListeners();
  }

  get user => _firebaseAuth.currentUser;

  getAuthState() => _firebaseAuth.authStateChanges();

  Future signIn({required String email, required String password}) async {
    setIsAuthLoading(true);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setIsAuthLoading(false);
    } catch (e) {
      setIsAuthLoading(false);
      rethrow;
    }
  }

  Future signUp({required String email, required String password}) async {
    setIsAuthLoading(true);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setIsAuthLoading(false);
    } catch (e) {
      setIsAuthLoading(false);
      rethrow;
    }
  }

  Future resetPassword({required String email}) async {
    setIsAuthLoading(true);
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      setIsAuthLoading(false);
    } catch (e) {
      setIsAuthLoading(false);
      rethrow;
    }
  }

  Future googleSignIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) throw const HttpException('SignIn failed.');
      // else
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future facebookSignIn() async {}

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
