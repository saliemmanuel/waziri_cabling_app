//Ici déclaré tous les variables de connexion au serveur distant

class Host {
  Uri baseUrl({String? endpoint}) =>
      Uri.parse("http://192.168.137.1:3366/api/$endpoint/");
  Map<String, String> headers = {"Accept": "application/json"};
}
