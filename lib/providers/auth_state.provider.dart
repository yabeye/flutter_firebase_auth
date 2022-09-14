import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_auth/enum/app_state.dart';
import 'package:flutter_firebase_auth/providers/auth.provider.dart';
import 'package:flutter_firebase_auth/providers/base.provider.dart';

class AuthStateProvider extends BaseProvider {
  switchAuthenticationState(AuthProvider authModel) {
    authModel.authState == AuthState.signIn
        ? authModel.setAuthState(AuthState.signUp)
        : authModel.setAuthState(AuthState.signIn);
  }

  switchAuthenticationMethod(
    AuthProvider authModel,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    authModel.authState == AuthState.signIn
        ? authModel.signIn(
            emailController.text,
            passwordController.text,
          )
        : authModel.createNewUser(
            emailController.text,
            passwordController.text,
          );
  }

  switchAuthenticationText(AuthProvider authModel) {
    return authModel.authState == AuthState.signIn ? "Sign In" : "Sign Up";
  }

  switchAuthenticationOption(AuthProvider authModel) {
    return authModel.authState == AuthState.signIn
        ? "Create account ??"
        : "Already registered ??";
  }
}
