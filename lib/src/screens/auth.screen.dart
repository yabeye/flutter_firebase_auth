import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/src/providers/auth.providers.dart';
import 'package:flutter_firebase_auth/src/utils/helpers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthProvider? _authProvider;
  bool isSignIn = true;

  bool _onInit = true;

  Future signIn() async {
    try {
      await _authProvider!.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } catch (e) {
      Helpers.showErrorDialog("Unable to sign in ! Please Try Again!", context);
    }
  }

  Future signUp() async {
    try {
      await _authProvider!.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } catch (e) {
      Helpers.showErrorDialog("Unable to sign up. Please Try Again!", context);
    }
  }

  Future googleSignIn() async {
    try {
      await _authProvider!.googleSignIn();
    } on FirebaseException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } on HttpException catch (_) {
      Helpers.showErrorDialog("Try Again!", context);
    } catch (e) {
      Helpers.showErrorDialog("Unable to do that!", context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_onInit) {
      _authProvider = Provider.of<AuthProvider>(context);
    }
    _onInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Firebase Auth'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    isSignIn ? 'Sign In' : 'Register',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                      onPressed: isSignIn ? signIn : signUp,
                      child: _authProvider!.isAuthLoading
                          ? const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                // value: 2,
                                strokeWidth: 3.0,
                              ),
                            )
                          : Text(
                              isSignIn ? 'SignIn' : 'SignUp',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SocialLogin(
                          socialIcon: FontAwesomeIcons.google,
                          socialIconColor: Colors.red,
                          socialName: 'Google',
                          onTap: googleSignIn,
                        ),
                        SocialLogin(
                          socialIcon: FontAwesomeIcons.facebook,
                          socialIconColor: Colors.blue,
                          socialName: 'Facebook',
                          onTap: () {
                            debugPrint("Facebook LogIn");
                            Helpers.showErrorDialog(
                              "Coming Soon. Not Implemented",
                              context,
                            );
                          },
                        ),
                        SocialLogin(
                          socialIcon: FontAwesomeIcons.github,
                          socialIconColor: Colors.black,
                          socialName: 'GitHub',
                          onTap: () {
                            debugPrint("Github LogIn");
                            Helpers.showErrorDialog(
                              "Coming Soon. Not Implemented",
                              context,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isSignIn
                          ? 'don\'t have an account?'
                          : 'have an account?'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextButton(
                          onPressed: () {
                            isSignIn = !isSignIn;
                            setState(() {});
                          },
                          child: Text(
                            isSignIn ? 'SignUp' : 'SignIn',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  IconData socialIcon;
  Color socialIconColor;
  String socialName;
  Function onTap;

  SocialLogin({
    Key? key,
    required this.socialIcon,
    required this.socialIconColor,
    required this.socialName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.blue,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              )),
          child: IconButton(
            onPressed: () => onTap(),
            icon: FaIcon(
              socialIcon,
              color: socialIconColor,
              size: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(socialName),
        ),
      ],
    );
  }
}
