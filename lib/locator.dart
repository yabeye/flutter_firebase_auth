import 'package:flutter_firebase_auth/providers/auth.provider.dart';
import 'package:flutter_firebase_auth/providers/auth_state.provider.dart';
import 'package:flutter_firebase_auth/providers/base.provider.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseProvider());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => AuthStateProvider());
}
