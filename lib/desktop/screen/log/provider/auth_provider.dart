import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/models/users.dart';

class AuthProvider extends ChangeNotifier {
  final _service = ServiceApi();
  Users _users = Users();
  bool _isLogged = false;
  bool _sessionActive = false;
  bool _codeIsCorrect = false;
  final _storage = const FlutterSecureStorage();

  bool get codeIsCorrect => _codeIsCorrect;
  bool get userIsLogged => _isLogged;
  bool get sessionActive => _sessionActive;
  Users get user => _users;

  void connexion({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    _isLogged = await _service.connexion(
      email: email,
      password: password,
      context: context,
    );
    notifyListeners();
  }

  void userData({var token}) async {
    var data = await _service.getUserData(token: token);
    if (data['id'] != null) {
      _users = Users.fromMap({
        "id": data['id'],
        "nomUtilisateur": data['nom_utilisateur'],
        "email": data['email'],
        "prenomUtilisateur": data['prenom_utilisateur'],
        "telephoneUtilisateur": data['telephone_utilisateur'].toString(),
        "roleUtilisateur": data['role_utilisateur'],
        "zoneUtilisateur": data['zone_utilisateur'],
        "idUtilisateurInitiateur": data['idUtilisateurInitiateur']
      });
      await _storage.write(key: "tokens", value: token);
    }
    print(token);
    notifyListeners();
  }

  setSessionActive({bool? session}) async {
    _sessionActive = session!;
    await _storage.write(key: "session", value: session.toString());
    print(_sessionActive);
    notifyListeners();
  }

  void logout({dynamic context}) async {
    var token = await _storage.read(key: "tokens");
    _isLogged = await _service.deconnexion(token: token, context: context);
    _codeIsCorrect = false;
    Provider.of<HomeProvider>(context, listen: false).changeBody(index: 0);
    _storage.deleteAll();
    _users = Users(
      id: null,
      email: null,
      idUtilisateurInitiateur: null,
      nomUtilisateur: null,
      prenomUtilisateur: null,
      roleUtilisateur: null,
      telephoneUtilisateur: null,
      zoneUtilisateur: null,
    );
    notifyListeners();
  }

  readLocalData({String? key}) async => await _storage.read(key: key!);

  codeAuth({
    String? code,
    String? idAmin,
    required dynamic context,
  }) async {
    var token = await _storage.read(key: "tokens");
    _codeIsCorrect = await _service.getAuthCode(
        code: code, idAmin: idAmin, token: token, context: context);
    return _codeIsCorrect;
  }

  setCodeToFalse({bool value = false}) {
    _codeIsCorrect = value;
    notifyListeners();
  }
}
