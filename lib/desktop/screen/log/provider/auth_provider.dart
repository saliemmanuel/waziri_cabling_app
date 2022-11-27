import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/api/service_api.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogged = false;
  bool get userIsLogged => _isLogged;

  void connexion(
      {String? email, String? password, BuildContext? context}) async {
    var service = ServiceApi();
    if (await service.connexion(
        email: email, password: password, context: context)) {
      login(true);
    }
    notifyListeners();
  }

  void logout() {
    _isLogged = !_isLogged;
    notifyListeners();
  }

  void login(var value) {
    _isLogged = value;
    notifyListeners();
  }
}
