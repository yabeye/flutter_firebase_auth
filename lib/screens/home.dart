import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firebaseUser = authProvider.getCurrentUser;

    debugPrint("Auth Provider ${authProvider.authStateChanges}");

    return Center(
      child: Column(
        children: [
          const Text("Home Page"),
          Text("Email: ${firebaseUser?.email}"),
          Text("Is Anonymous: ${firebaseUser?.isAnonymous}"),
          TextButton(
              onPressed: () {
                authProvider.logout();
              },
              child: const Text("Logout")),
        ],
      ),
    );
  }
}
