import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waziri_cabling_app/api/service_api.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ServiceApi();
  dynamic _listUtilisateur;
  dynamic _searcheItem;

  get listUtilisateur => _listUtilisateur;

  get seachItem => _searcheItem;
  providelistUtilisateur() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    _listUtilisateur = await _service.getListUtilisateur(token: token);
    notifyListeners();
  }
}
