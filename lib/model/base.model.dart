import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/enum/app_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _viewState = ViewState.ideal;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  AuthState _authState = AuthState.signIn;

  AuthState get authState => _authState;

  setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }
}
