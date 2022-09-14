import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/enum/app_state.dart';
import 'package:flutter_firebase_auth/providers/auth.provider.dart';
import 'package:flutter_firebase_auth/providers/auth_state.provider.dart';
import 'package:flutter_firebase_auth/ui/base_view.dart';
import 'package:flutter_firebase_auth/utils/helpers.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false, _isInit = true;
  AuthProvider? authProvider;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  actionLogin() async {
    _isLoading = true;
    setState(() {});

    try {
      authProvider?.signIn(emailController.text, passwordController.text);
    } on HttpException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } on SocketException catch (_) {
      Helpers.showErrorDialog(
        'Please check your internet connection and try again.',
        context,
      );
    } catch (e) {
      Helpers.showErrorDialog(
        'Unable to to do that right now. Try again.',
        context,
      );
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      authProvider = Provider.of<AuthProvider>(context);
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Getting out!");
    authProvider!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthStateProvider>(
      builder: (context, authStateModel, __) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  authProvider!.viewState == ViewState.busy
                      ? const CircularProgressIndicator()
                      : TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFF02BCFF),
                            ),
                          ),
                          onPressed: () {
                            authStateModel.switchAuthenticationMethod(
                              authProvider!,
                              emailController,
                              passwordController,
                            );
                          },
                          child: Text(
                            authStateModel
                                .switchAuthenticationText(authProvider!),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      authStateModel.switchAuthenticationState(authProvider!);
                    },
                    child: Text(
                      authStateModel.switchAuthenticationOption(authProvider!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
