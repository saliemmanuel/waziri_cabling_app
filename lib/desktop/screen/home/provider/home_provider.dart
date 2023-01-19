import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ServiceApi();
  dynamic _listUtilisateur;
  dynamic _listSecteur;
  dynamic _listTypeAbonnement;
  dynamic _listAbonnes;
  dynamic _listFactures;
  int _topIndex = 0;

  get listUtilisateur => _listUtilisateur;
  get listSecteur => _listSecteur;
  get listTypeAbonnement => _listTypeAbonnement;
  get listAbonnes => _listAbonnes;
  get listFactures => _listFactures;
  get topIndex => _topIndex;

  providelistUtilisateur() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listUtilisateur = await _service.getListUtilisateur(token: token);
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

  dynamic _listTrie = [];
  get listTrie => _listTrie;

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
        print(_listTrie);
      }
    }
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

  changeBody({int? index}) {
    _topIndex = index!;
    notifyListeners();
  }

  deconnexion() {
    _listUtilisateur = null;
    _listSecteur = null;
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
