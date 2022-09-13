import 'package:flutter_firebase_auth/model/auth.model.dart';
import 'package:flutter_firebase_auth/model/auth_state.model.dart';
import 'package:flutter_firebase_auth/model/base.model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => AuthModel());
  locator.registerLazySingleton(() => AuthStateModel());
}
