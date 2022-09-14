import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/providers/auth.provider.dart';
import 'package:flutter_firebase_auth/providers/user.provider.dart';
import 'package:flutter_firebase_auth/ui/base_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return BaseView<AuthProvider>(
      builder: (context, model, __) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Current User"),
              Text(
                  "Email: ${authProvider.user!.id.toString().substring(0, 6)}"),
              Text("Email: ${authProvider.user.email}"),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0XFF02BCFF),
                  ),
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  model.logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
