import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/add_secteur.dart';
import 'package:waziri_cabling_app/models/secteur.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ServiceApi();
  dynamic _listUtilisateur;
  dynamic _listSecteur;
  int _topIndex = 0;

  get listUtilisateur => _listUtilisateur;
  get topIndex => _topIndex;

  get listSecteur => _listSecteur;
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
    print(_listSecteur);
    notifyListeners();
  }

  addSecteur({Secteur? secteur, required BuildContext? context}) async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _service.addSecteur(token: token, secteur: secteur!, context: context);
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
}
