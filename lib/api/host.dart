//Ici déclaré tous les variables de connexion au serveur distant

class Host {
  static var host = 'http://192.168.137.210:3366';
  // static var host = 'https://waziricablingapp.000webhostapp.com';

  Uri baseUrl({String? endpoint}) => Uri.parse("$host/api/$endpoint/");
  String baseUrl2({String? endpoint}) => "$host/api/$endpoint/";

  Map<String, String> headers(String bearer) =>
      {"Accept": "application/json", "Authorization": "Bearer $bearer"};
}
