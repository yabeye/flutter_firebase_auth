import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLogIn = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    TextButton myButton() {
      return TextButton(
        onPressed: _isLogIn
            ? () => authProvider.logIn(
                email: emailController.text, password: passwordController.text)
            : () => authProvider.signUp(
                email: emailController.text, password: passwordController.text),
        child: authProvider.isLoading
            ? const CircularProgressIndicator()
            : _isLogIn
                ? const Text("Login")
                : const Text("SignUp"),
      );
    }

    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: "Email"),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(hintText: "Password"),
        ),
        myButton(),
        GestureDetector(
          onTap: () => {
            setState(() => {_isLogIn = !_isLogIn})
          },
          child: Text(
            _isLogIn ? "SignUp" : "LogIn",
          ),
        ),
      ],
    );
  }
}
