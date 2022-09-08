import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/providers/auth_provider.dart';
import 'package:flutter_firebase_auth/screens/home.dart';
import 'package:flutter_firebase_auth/screens/signin.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthProvider>(
            create: (_) => AuthProvider(FirebaseAuth.instance, false),
          ),
          StreamProvider(
            create: (ctx) => ctx.read<AuthProvider>().authStateChanges,
            initialData: null,
          )
        ],
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Firebase Auth',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const AuthenticationWrapper(),
          );
        });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Flutter Firebase Auth",
        ),
      ),
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            }
            return const SignIn();
          },
        ),
      ),
    );
  }
}
