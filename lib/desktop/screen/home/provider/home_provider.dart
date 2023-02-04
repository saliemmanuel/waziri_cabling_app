import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';
import 'package:waziri_cabling_app/models/materiel_models.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../models/pannes_models.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ServiceApi();
  List _listUtilisateur = [];
  dynamic _listSecteur = [];
  dynamic _listTypeAbonnement = [];
  dynamic _listAbonnes = [];
  dynamic _listMateriels = [];
  dynamic _listPannes = [];
  dynamic _listFactures;
  int _topIndex = 0;
  dynamic _listTrie = [];

  get listUtilisateur => _listUtilisateur;
  get listSecteur => _listSecteur;
  get listTypeAbonnement => _listTypeAbonnement;
  get listAbonnes => _listAbonnes;
  get listMateriels => _listMateriels;
  get listPannes => _listPannes;
  get listFactures => _listFactures;
  get topIndex => _topIndex;
  get listTrie => _listTrie;

  providelistUtilisateur(var selectedTypeUtilisateur) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    dynamic tmp;
    tmp = await _service.getListUtilisateur(token: token);
    try {
      if (tmp != null) {
        var temp = tmp['utilisateur'];
        if (temp != []) {
          _listUtilisateur.clear();
          for (var i in temp) {
            if (i['role_utilisateur']
                .toString()
                .contains(selectedTypeUtilisateur!)) {
              _listUtilisateur.add(i);
            } else if (selectedTypeUtilisateur
                .contains('Tout les utilisateurs')) {
              _listUtilisateur.add(i);
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
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

  provideListeAbonnes({required Users? users}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listAbonnes = await _service.getListAbonnes(token: token, users: users);
    notifyListeners();
  }

  provideMateriels() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listMateriels = await _service.getListMateriel(token: token);
    notifyListeners();
  }

  providePannes() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listPannes = await _service.getListPannes(token: token);
    notifyListeners();
  }

  provideListeFacture(
      {required Users? users, required String? selectedStatut}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listFactures = await _service.getListFacture(token: token, users: users);
    if (_listFactures != null) {
      var temp = _listFactures['facture'];
      if (temp != []) {
        _listTrie.clear();
        for (var i in temp) {
          if (i['statut_facture'].toString().contains(selectedStatut!)) {
            _listTrie.add(i);
          } else if (selectedStatut.contains('Toute les factures')) {
            _listTrie.add(i);
          }
        }
      }
    }
    notifyListeners();
  }

  searchInLIstFacture(String query, var keys) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listTrie;
    } else {
      results = _listTrie
          .where((element) => element[keys]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listTrie = results;
    notifyListeners();
  }

  searchInListUtilisateur(String query, var keys) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listUtilisateur;
    } else {
      results = _listUtilisateur
          .where((element) => element[keys]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listUtilisateur = results;
    notifyListeners();
  }

  searchInListSecteur(String query, var keys) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listSecteur;
    } else {
      results = _listSecteur
          .where((element) => element[keys]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listSecteur = results;
    notifyListeners();
  }

  searchInListAbonne(String query, var keys) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listAbonnes;
    } else {
      results = _listAbonnes
          .where((element) => element[keys]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listAbonnes = results;
    notifyListeners();
  }

  searchInListTypeAbonnement(String query, var keys) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listTypeAbonnement;
    } else {
      results = _listTypeAbonnement
          .where((element) => element[keys]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listTypeAbonnement = results;
    notifyListeners();
  }

  searchInListMateriel(String query) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listMateriels;
    } else {
      results = _listMateriels
          .where((element) => element['designation_materiel']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listMateriels = results;
    notifyListeners();
  }

  searchInListPannes(String query) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listPannes;
    } else {
      results = _listPannes
          .where((element) => element['designation']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listPannes = results;
    notifyListeners();
  }

  generateFacture({required Users? users}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    await _service.getGenerateFacture(token: token);
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

  addMateriel(
      {required MaterielModels? materiel,
      required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');

    _service.addMateriel(token: token, materiel: materiel!, context: context);
  }

  payementFacture(
      {required FactureModels? facture, required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.getPayementFacture(
        token: token, facture: facture!, context: context);
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

  addTypeAbonnement({
    TypeAbonnement? type,
    required var context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addTypeAbonnement(token: token, type: type, context: context);
    notifyListeners();
  }

  addAbonnes({
    AbonneModels? abonne,
    required var context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addAbonne(token: token, abonne: abonne, context: context);
    notifyListeners();
  }

  addPannes({
    PannesModels? panne,
    required var context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.getAddPanne(token: token, panne: panne, context: context);
    notifyListeners();
  }

  changeBody({int? index}) {
    _topIndex = index!;
    notifyListeners();
  }

  deconnexion() {
    _listUtilisateur.clear();
    if (_listSecteur != null) {
      _listSecteur.clear();
    }
    if (_listTrie != null) {
      _listTrie.clear();
    }
    _listTypeAbonnement = null;
    _listAbonnes = null;
    _topIndex = 0;
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

  getDeleteAbonne({
    AbonneModels? abonne,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteAbonne(
      context: context,
      abonne: abonne,
      token: token,
    );
  }

  getDeleteMateriel({
    MaterielModels? materiel,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteMateriel(
      context: context,
      materiel: materiel,
      token: token,
    );
  }

  getDeletePannes({
    PannesModels? pannes,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deletePannes(
      context: context,
      pannes: pannes,
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
}
