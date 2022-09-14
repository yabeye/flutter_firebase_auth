import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/enum/app_state.dart';
import 'package:flutter_firebase_auth/models/user.model.dart';
import 'package:flutter_firebase_auth/providers/user.provider.dart';
import 'package:flutter_firebase_auth/utils/helpers.dart';

import 'base.provider.dart';

class AuthProvider extends BaseProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel? _user = UserModel(id: "", email: '');

  get user => _user;

  setUser(newUser) {
    _user = newUser;
    notifyListeners();
  }

  void createNewUser(String email, String password) async {
    setViewState(ViewState.busy);
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    setViewState(ViewState.ideal);
  }

  Future<String?> signIn(String email, String password) async {
    setViewState(ViewState.busy);

    String returnResult = "";
    try {
      final authResponse = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = authResponse.user;
      if (userData != null) {
        final UserModel newUser = UserModel(
          id: userData.uid,
          email: userData.email ?? '',
        );
        setUser(newUser);
        debugPrint("New User: ${newUser.id} and ${newUser.email}");
      } else {
        debugPrint("Couldn't Login! Try Again!");
      }
    } catch (e) {
      returnResult = "Couldn't sign in at the moment. Try Again!";
      rethrow;
    }

    debugPrint("Return Result: $returnResult");

    setViewState(ViewState.ideal);
    return returnResult;
  }

  void logOut() async {
    setViewState(ViewState.busy);
    await firebaseAuth.signOut();
    setViewState(ViewState.ideal);
  }

  void dispose() {
    setUser(null);
    setAuthState(AuthState.signIn);
    setViewState(ViewState.ideal);
  }
}
