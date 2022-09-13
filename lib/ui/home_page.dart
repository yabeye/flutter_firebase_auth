import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/model/auth.model.dart';
import 'package:flutter_firebase_auth/ui/base_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthModel>(
      builder: (context, model, __) => Scaffold(
        body: Center(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0XFF02BCFF),
              ),
            ),
            child: const Text("Log Out"),
            onPressed: () {
              model.logOut();
            },
          ),
        ),
      ),
    );
  }
}
