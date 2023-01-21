import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/add_type_abonnemet.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../desktop/screen/log/provider/auth_provider.dart';
import '../global_widget/custom_dialogue_card.dart';
import 'host.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  var host = Host();
  bool isEmail(String email) {
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static formatDate(String date) {
    DateTime? datemsg;
    var annee = int.parse(date.substring(0, 4));
    var mois = int.parse(date.substring(5, 7));
    var jour = int.parse(date.substring(8, 10));
    var heur = int.parse(date.substring(11, 13));
    var min = int.parse(date.substring(14, 16));
    var sec = int.parse(date.substring(17, 19));
    datemsg = DateTime(annee, mois, jour, heur, min, sec);
    var datenow = DateTime.now();
    var different = datenow.difference(datemsg);
    if (different.inDays > 8) {
      return '$jour-$mois-$annee a $heur h $min min';
    }
  }

  // inscription
  connexion({String? email, String? password, var context}) async {
    dynamic response;
    try {
      simpleDialogueCardSansTitle(
        msg: "Patientez svp ...",
        context: context,
        barrierDismissible: false,
      );
      if (isEmail(email!)) {
        var data = await http.post(
            host.baseUrl(endpoint: "utilisateur/connexion"),
            headers: host.headers(""),
            body: {
              "email": email,
              'password': password,
              "device_name": 'telephone.$email'
            }).timeout(const Duration(seconds: 10), onTimeout: () {
          throw TimeoutException(
              'Connexion perdue, verifier votre connexion internet');
        });
        if (data.statusCode > 201) {
          response = jsonDecode(data.body);
          Navigator.pop(context);
          errorDialogueCard("Erreur", response['message'], context);
          return false;
        }
        if (data.statusCode == 200) {
          response = jsonDecode(data.body);
          Navigator.pop(context);
          Provider.of<AuthProvider>(context, listen: false)
              .userData(token: response['token']);
          return true;
        }
      } else {
        echecTransaction("Entrez un e-mail valide", context!);
        return false;
      }
    } catch (e) {
      errorDialogueCard("Erreur", "$e", context)
          .then((value) => Navigator.pop(context));
      return false;
    }
  }

  getUserData({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "utilisateur/user-data"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return jsonDecode(data.body);
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {}
  }

  deconnexion({String? token, var context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Déconnexion...", context: context, barrierDismissible: true);
      var data = await http
          .get(host.baseUrl(endpoint: "utilisateur/deconnexion"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        Navigator.pop(context);
        echecTransaction("Erreur lors de la déconnexion", context);
        return true;
      }
      if (data.statusCode == 200) {
        Navigator.pop(context);
        return false;
      }
    } catch (e) {}
  }

  getListUtilisateur({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "utilisateur/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {}
  }

  getListSecteur({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "secteur/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {}
  }

  addSecteur(
      {String? token, Secteur? secteur, required BuildContext? context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);

      var data = await http.post(
          host.baseUrl(endpoint: "secteur/ajout-secteur"),
          headers: host.headers(token!),
          body: {
            "designation_secteur": secteur!.designationSecteur,
            "description_secteur": secteur.descriptionSecteur,
            "nom_chef_secteur": secteur.nomChefSecteur,
            "id_chef_secteur": secteur.idChefSecteur,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode > 300) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        echecTransaction(
            "Erreur lors de la création. ${response['message']}", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  getPayementFacture(
      {String? token,
      FactureModels? facture,
      required BuildContext? context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);

      var data = await http.post(host.baseUrl(endpoint: "facture/payement"),
          headers: host.headers(token!),
          body: {
            "id_facture": facture!.idFacture,
            "numero_facture": facture.numeroFacture,
            "mensualite_facture": facture.mensualiteFacture,
            "montant_verser": facture.montantVerser,
            "reste_facture": facture.resteFacture,
            "statut_facture": facture.statutFacture,
            "impayes": facture.impayes,
            "id_abonne": facture.idAbonne,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode > 300) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        echecTransaction(
            "Erreur lors de la création. ${response['message']}", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  getAuthCode(
      {String? code,
      String? idAmin,
      String? token,
      required var context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...",
          context: context!,
          barrierDismissible: false);

      var data = await http.post(host.baseUrl(endpoint: "code/get-code"),
          headers: host.headers(token!),
          body: {
            "code_admin": code,
            "id_admin": idAmin
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode == 200) {
        Navigator.pop(context);
        var response = await jsonDecode(data.body);
        if (response['statut']) {
          Navigator.pop(context);
          return response['statut'];
        } else {
          echecTransaction(response['message'], context);
          return response['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  deleteUser(
      {String? idUser,
      String? email,
      String? token,
      required var context}) async {
    try {
      var data = await http.post(
          host.baseUrl(endpoint: "utilisateur/delete-user"),
          headers: host.headers(token!),
          body: {
            "id": idUser,
            "email": email
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        if (response['statut']) {
          succesTransaction(response['message'], context);
          return response['statut'];
        } else {
          echecTransaction(response['message'], context);
          return response['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  deleteAbonne(
      {AbonneModels? abonne, String? token, required var context}) async {
    try {
      var data = await http.post(host.baseUrl(endpoint: "abonne/delete-abonne"),
          headers: host.headers(token!),
          body: {
            "id": abonne!.id,
            "prenom_abonne": abonne.prenomAbonne,
            "cni_abonne": abonne.cniAbonne,
            "telephone_abonne": abonne.telephoneAbonne
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        if (response['statut']) {
          succesTransaction(response['message'], context);
          return response['statut'];
        } else {
          echecTransaction(response['message'], context);
          return response['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  storeAdministrationCode(
      {String? idUser,
      String? codeAdmin,
      String? token,
      required var context}) async {
    try {
      var data = await http.post(host.baseUrl(endpoint: "code/store"),
          headers: host.headers(token!),
          body: {
            "code_admin": codeAdmin,
            "id_admin": idUser
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        if (response['statut']) {
          return response['statut'];
        } else {
          echecTransaction(response['message'], context);
          return response['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  addUtilisateur(
      {String? token,
      Users? users,
      required String idUtilisateurInitiateur,
      required var context}) async {
    try {
      simpleDialogueCardSansTitle(msg: "Patientez svp...", context: context!);

      var data = await http.post(
          host.baseUrl(endpoint: "utilisateur/ajout-user"),
          headers: host.headers(token!),
          body: {
            'nom_utilisateur': users!.nomUtilisateur,
            'prenom_utilisateur': users.prenomUtilisateur,
            'email': users.email,
            'telephone_utilisateur': users.telephoneUtilisateur,
            'role_utilisateur': users.roleUtilisateur,
            'zone_utilisateur': users.zoneUtilisateur,
            'id_utilisateur_initiateur': idUtilisateurInitiateur,
            'password': users.roleUtilisateur
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        var response = await jsonDecode(data.body);

        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);

        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  updateUtilisateur(
      {String? token,
      Users? users,
      required String idUtilisateurInitiateur,
      required var context}) async {
    try {
      simpleDialogueCardSansTitle(msg: "Patientez svp...", context: context!);

      var data = await http.post(host.baseUrl(endpoint: "utilisateur/update"),
          headers: host.headers(token!),
          body: {
            'nom_utilisateur': users!.nomUtilisateur,
            'prenom_utilisateur': users.prenomUtilisateur,
            'email': users.email,
            'telephone_utilisateur': users.telephoneUtilisateur,
            'role_utilisateur': users.roleUtilisateur,
            'zone_utilisateur': users.zoneUtilisateur,
            'id_utilisateur_initiateur': idUtilisateurInitiateur
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        Navigator.pop(context);
        echecTransaction("Erreur lors de la modification.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteSecteur({
    Secteur? secteur,
    String? token,
    required var context,
  }) async {
    try {
      var data = await http.post(
          host.baseUrl(endpoint: "secteur/delete-secteur"),
          headers: host.headers(token!),
          body: {
            "id": secteur!.id.toString(),
            "designation_secteur": secteur.designationSecteur
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        if (response['statut']) {
          succesTransaction(response['message'], context);
          return response['statut'];
        } else {
          echecTransaction(response['message'], context);
          return response['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getListTypeAbonnement({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "type-abonnemnt/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {}
  }

  deleteTypeAbonnement(
      {TypeAbonnement? type, String? token, required var context}) async {
    try {
      var data = await http.post(
          host.baseUrl(endpoint: "type-abonnemnt/delete-type"),
          headers: host.headers(token!),
          body: {
            "id": type!.id.toString(),
            "montant": type.montant,
            "designation_type_abonnement": type.designationTypeAbonnement,
            "nombre_chaine": type.nombreChaine
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });

      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        if (response['statut']) {
          succesTransaction(response['message'], context);
          return response['statut'];
        } else {
          echecTransaction(response['message'], context);
          return response['statut'];
        }
      }
    } catch (e) {
      echecTransaction('$e', context);
    }
  }

  addTypeAbonnement(
      {String? token, TypeAbonnement? type, required var context}) async {
    try {
      simpleDialogueCardSansTitle(msg: "Patientez svp...", context: context!);

      var data = await http.post(
          host.baseUrl(endpoint: "type-abonnemnt/ajout-type"),
          headers: host.headers(token!),
          body: {
            'designation_type_abonnement': type!.designationTypeAbonnement,
            'montant': type.montant,
            'nombre_chaine': type.nombreChaine,
            'id_initiateur': type.idInitiateur,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        var response = await jsonDecode(data.body);

        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);

        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  addAbonne({
    String? token,
    AbonneModels? abonne,
    required var context,
  }) async {
    try {
      simpleDialogueCardSansTitle(msg: "Patientez svp...", context: context!);

      var data = await http.post(host.baseUrl(endpoint: "abonne/ajout-abonne"),
          headers: host.headers(token!),
          body: {
            'nom_abonne': abonne!.nomAbonne,
            'prenom_abonne': abonne.prenomAbonne,
            'cni_abonne': abonne.cniAbonne,
            'telephone_abonne': abonne.telephoneAbonne,
            'description_zone_abonne': abonne.descriptionZoneAbonne,
            'secteur_abonne': abonne.secteurAbonne,
            'id_chef_secteur': abonne.idChefSecteur,
            'type_abonnement': abonne.typeAbonnement,
            'id_type_abonnement': abonne.idTypeAbonnement,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  getListAbonnes({String? token, required Users? users}) async {
    try {
      var data = await http
          .post(host.baseUrl(endpoint: "abonne/index"),
              body: {
                'id_chef_secteur': users!.id.toString(),
                'role_utilisateur': users.roleUtilisateur.toString(),
              },
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {
      print(e);
    }
  }

  ///
  ///
  ///
  getListFacture({String? token, required Users? users}) async {
    try {
      var data = await http
          .post(host.baseUrl(endpoint: "facture/index"),
              body: {
                'id_chef_secteur': users!.id.toString(),
                'role_utilisateur': users.roleUtilisateur.toString(),
              },
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {
      print(e);
    }
  }

  getGenerateFacture({String? token}) async {
    try {
      var data = await http
          .post(host.baseUrl(endpoint: "facture/generate-facture"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return jsonDecode(data.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
