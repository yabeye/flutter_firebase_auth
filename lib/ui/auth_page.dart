import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/enum/app_state.dart';
import 'package:flutter_firebase_auth/model/auth.model.dart';
import 'package:flutter_firebase_auth/model/auth_state.model.dart';
import 'package:flutter_firebase_auth/ui/base_view.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthModel authModel;

  const AuthPage({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.authModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthStateModel>(builder: (context, authStateModel, __) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Email"),
                  controller: emailController,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                authModel.viewState == ViewState.busy
                    ? const CircularProgressIndicator()
                    : TextButton(
                        style: const ButtonStyle(
                            // backgroundColor:,
                            ),
                        onPressed: () {
                          authStateModel.switchAuthenticationMethod(
                              authModel, emailController, passwordController);
                        },
                        child: Text(
                            authStateModel.switchAuthenticationText(authModel)),
                      ),
                InkWell(
                  onTap: () {
                    authStateModel.switchAuthenticationState(authModel);
                  },
                  child: Text(
                      authStateModel.switchAuthenticationOption(authModel)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
