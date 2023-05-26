// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/charge_models.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';
import 'package:waziri_cabling_app/models/materiel_models.dart';
import 'package:waziri_cabling_app/models/message_moi_models.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';
import 'package:waziri_cabling_app/models/versement_models.dart';

import '../../../../models/pannes_models.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ServiceApi();
  List _listUtilisateur = [];
  dynamic _listSecteur = [];
  dynamic _listTypeAbonnement = [];
  dynamic _listAbonnes = [];
  dynamic _listMateriels = [];
  dynamic _listPannes = [];
  dynamic _listComptaData = [];
  dynamic _listVersements = [];
  dynamic _listMessageMois = [];
  dynamic _listCharget = [];
  dynamic _listFactures;
  int _topIndex = 0;
  dynamic _listTrie = [];

  get listUtilisateur => _listUtilisateur;
  get listSecteur => _listSecteur;
  get listTypeAbonnement => _listTypeAbonnement;
  get listAbonnes => _listAbonnes;
  get listMateriels => _listMateriels;
  get listPannes => _listPannes;
  get listVersements => _listVersements;
  get listMessageMois => _listMessageMois;
  get listCharge => _listCharget;
  get listFactures => _listFactures;
  get topIndex => _topIndex;
  get listTrie => _listTrie;
  get listComptaData => _listComptaData;

  providelistUtilisateur(var selectedTypeUtilisateur) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    print(token);
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
      debugPrint(e.toString());
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

  provideVersements() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listVersements = await _service.getListVersement(token: token);
    notifyListeners();
  }

  provideCharge() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listCharget = await _service.getListCharge(token: token);
    notifyListeners();
  }

  provideMessageMoi() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listMessageMois = await _service.getListMessageMois(token: token);
    notifyListeners();
  }

  providePannes() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listPannes = await _service.getListPannes(token: token);
    notifyListeners();
  }

  provideComptabiliteData() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listComptaData = await _service.getComptabiliteData(token: token);
    notifyListeners();
  }

  updateComptabiliteData() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listComptaData = await _service.getUpdateComptabiliteData(token: token!);
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

  searchInListVersement(String query) {
    dynamic results = [];
    if (query.isEmpty) {
      results = _listVersements;
    } else {
      results = _listVersements
          .where((element) => element['nom_secteur']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    _listVersements = results;
    notifyListeners();
  }

  generateFacture({required Users? users, required var context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    await _service.getGenerateFacture(token: token, context: context);
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

  getUpdateMateriel(
      {required MaterielModels? materiel,
      required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');

    _service.updateMateriel(token: token, materiel: materiel, context: context);
  }

  addVersement(
      {required VersementModels? versement,
      required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addVersement(
        token: token, versement: versement!, context: context);
  }

  addCharge(
      {required ChargeModels? charge, required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addCharge(token: token, charge: charge!, context: context);
  }

  addMessageMois(
      {required MessageMoisModel? messageMois,
      required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addMessageMois(
        token: token, messageMois: messageMois!, context: context);
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

  getDeleteVersement({
    VersementModels? versement,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteVersement(
      context: context,
      versement: versement,
      token: token,
    );
  }

  getDeleteMessageMois({
    MessageMoisModel? message,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteMessageMois(
      context: context,
      message: message,
      token: token,
    );
  }

  getDeleteCharge({
    ChargeModels? charge,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteCharge(
      context: context,
      charge: charge,
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
    notifyListeners();
  }

  getUpadeteSecteur({
    Secteur? secteur,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateSecteur(context: context, secteur: secteur, token: token);
    notifyListeners();
  }

  getUpdateTypeAbonnement({
    TypeAbonnement? type,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateTypeAbonnement(context: context, type: type, token: token);
    notifyListeners();
  }

  getUpadeteAbonne({
    AbonneModels? abonneModels,
    required dynamic context,
    required Users? users,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateAbonne(
        users: users,
        context: context,
        abonneModels: abonneModels,
        token: token);
    notifyListeners();
  }

  getUpadetePanne({
    PannesModels? pannesModels,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updatePanne(
        context: context, pannesModels: pannesModels, token: token);
    notifyListeners();
  }

  getUpadeteMessageMois({
    MessageMoisModel? messageMoisModel,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateMessageMois(
        context: context, messageMoisModel: messageMoisModel, token: token);
    notifyListeners();
  }

  getUpadeteVersement({
    VersementModels? versementModels,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateVersement(
        context: context, versementModels: versementModels, token: token);
    notifyListeners();
  }

  getUpdateCharge({
    ChargeModels? chargeModels,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.updateCharge(
        context: context, chargeModels: chargeModels, token: token);
    notifyListeners();
  }

  getDeleteTypeAbonnement({
    TypeAbonnement? type,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.deleteTypeAbonnement(context: context, type: type, token: token);
  }

  getDetailFacture({
    String? idAbonne,
    required dynamic context,
  }) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    return _service.detailFactureAbonne(
        context: context, idAbonne: idAbonne, token: token);
  }
}
