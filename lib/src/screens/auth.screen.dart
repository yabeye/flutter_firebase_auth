import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/src/providers/auth.providers.dart';
import 'package:flutter_firebase_auth/src/utils/helpers.dart';
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
  bool _onInit = true;

  Future<bool> signIn() async {
    try {
      await _authProvider!
          .signIn(emailController.text, passwordController.text);
    } on FirebaseAuthException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } catch (e) {
      Helpers.showErrorDialog("Unable to do that! Please Try Again!", context);
    }

    return false;
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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
                onPressed: signIn,
                child: _authProvider!.isAuthLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
