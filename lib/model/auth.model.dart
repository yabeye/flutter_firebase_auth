import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/enum/app_state.dart';

import 'base.model.dart';

class AuthModel extends BaseModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void createNewUser(String email, String password) async {
    setViewState(ViewState.busy);
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    setViewState(ViewState.ideal);
  }

  void signIn(String email, String password) async {
    setViewState(ViewState.busy);
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    setViewState(ViewState.ideal);
  }

  void logOut() async {
    setViewState(ViewState.busy);
    await firebaseAuth.signOut();
    setViewState(ViewState.ideal);
  }
}
