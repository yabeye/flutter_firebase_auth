import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_firebase_auth/model/auth.model.dart';
import 'package:flutter_firebase_auth/ui/auth_page.dart';
import 'package:flutter_firebase_auth/ui/base_view.dart';
import 'package:flutter_firebase_auth/ui/home_page.dart';

// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthModel>(
      builder: (context, authModel, child) => StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? const HomePage()
                : AuthPage(
                    emailController: emailController,
                    passwordController: passwordController,
                    authModel: authModel,
                  );
          }),
    );
  }
}

// class LoginModel extends BaseModel {
//   FirebaseAuth firebaseAuth;
//
//   login(String email, String password) async {
//     setViewState(ViewState.Busy);
//     await firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//     setViewState(ViewState.Ideal);
//   }
// }
