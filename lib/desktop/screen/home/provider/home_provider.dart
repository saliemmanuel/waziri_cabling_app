import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ServiceApi();
  dynamic _listUtilisateur;
  dynamic _listSecteur;
  dynamic _listTypeAbonnement;
  dynamic _listAbonnes;
  int _topIndex = 0;

  get listUtilisateur => _listUtilisateur;
  get listSecteur => _listSecteur;
  get listTypeAbonnement => _listTypeAbonnement;
  get listAbonnes => _listAbonnes;
  get topIndex => _topIndex;

  providelistUtilisateur() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listUtilisateur = await _service.getListUtilisateur(token: token);
    // print(_listSecteur);
    notifyListeners();
  }

  provideListSecteur() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listSecteur = await _service.getListSecteur(token: token);
    notifyListeners();
  }

  provideListeTypeAbonnement() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listTypeAbonnement = await _service.getListTypeAbonnement(token: token);
    notifyListeners();
  }

  provideListeAbonnes() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listAbonnes = await _service.getListAbonnes(token: token);
    print(_listAbonnes);
    notifyListeners();
  }

  addSecteur({Secteur? secteur, required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addSecteur(
      token: token,
      secteur: secteur!,
      context: context,
    );
  }

  changeBody({int? index}) {
    _topIndex = index!;
    notifyListeners();
  }

  getDeleteUser({
    String? idUser,
    String? email,
    String? token,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteUser(
      context: context,
      email: email,
      idUser: idUser,
      token: token,
    );
  }

  getInsertAdministrationCode({
    String? idUser,
    String? codeAdmin,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.storeAdministrationCode(
        token: token, idUser: idUser, codeAdmin: codeAdmin, context: context);
  }

  addNewUser({
    Users? users,
    required var context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addUtilisateur(
        idUtilisateurInitiateur: users!.idUtilisateurInitiateur.toString(),
        token: token,
        users: users,
        context: context);
    notifyListeners();
  }

  updateUtilisateur({required Users? users, required var context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateUtilisateur(
        idUtilisateurInitiateur: users!.idUtilisateurInitiateur.toString(),
        token: token,
        users: users,
        context: context);
    notifyListeners();
  }

  getDeleteSecteur({
    Secteur? secteur,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteSecteur(context: context, secteur: secteur, token: token);
  }

  getDeleteTypeAbonnement({
    TypeAbonnement? type,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteTypeAbonnement(context: context, type: type, token: token);
  }

  getAddTypeAbonnement({
    TypeAbonnement? type,
    required var context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addTypeAbonnement(token: token, type: type, context: context);
    notifyListeners();
  }
}
