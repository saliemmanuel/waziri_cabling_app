import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/charge_models.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';
import 'package:waziri_cabling_app/models/message_moi_models.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';
import 'package:waziri_cabling_app/models/versement_models.dart';

import '../desktop/screen/home/provider/home_provider.dart';
import '../desktop/screen/log/provider/auth_provider.dart';
import '../global_widget/custom_dialogue_card.dart';
import '../models/materiel_models.dart';
import '../models/pannes_models.dart';
import 'host.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  var host = Host();

  var dio = Dio();
  bool isEmail(String email) {
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static formatDate(String date, {bool enableMin = true}) {
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
      var valMin = '$heur h $min min';
      return '$jour-$mois-$annee  ${enableMin ? 'a $valMin' : ''}';
    }
  }

  connexion({String? email, String? password, var context}) async {
    try {
      simpleDialogueCardSansTitle(
        msg: "Patientez svp ...",
        context: context,
        barrierDismissible: false,
      );
      if (isEmail(email!)) {
        var data = await http
            .post(host.baseUrl(endpoint: "utilisateur/connexion"), body: {
          "email": email,
          'password': password,
          "device_name": 'telephone.$email'
        });
        var response = await jsonDecode(data.body);
        if (data.statusCode > 201) {
          Navigator.pop(context);
          errorDialogueCard("Connexion", response['message'], context);
          return false;
        }
        if (data.statusCode == 200) {
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
      errorDialogueCard("Erreur",
              'Connexion perdue, verifier votre connexion internet', context)
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
      var data = await dio.getUri(
          host.baseUrl(endpoint: "utilisateur/deconnexion"),
          options: Options(
              sendTimeout: 60 * 1000,
              receiveTimeout: 60 * 1000,
              headers: host.headers(token!)));
      if (data.statusCode! > 300) {
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
      var data = await dio
          .postUri(host.baseUrl(endpoint: "utilisateur/index"),
              options: Options(headers: host.headers(token!)))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode! > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return data.data;
      }
    } catch (e) {
      print(e);
    }
  }

  getListSecteur({String? token}) async {
    try {
      var data = await dio.getUri(host.baseUrl(endpoint: "secteur/index"),
          options: Options(headers: host.headers(token!)));
      if (data.statusCode! > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return data.data['secteurs'];
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

  addVersement(
      {String? token,
      VersementModels? versement,
      required BuildContext? context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);

      var data = await http.post(host.baseUrl(endpoint: "versement/store"),
          headers: host.headers(token!),
          body: {
            "nom_secteur": versement!.nomSecteur,
            "nom_chef_secteur": versement.nomChefSecteur,
            "somme_verser": versement.sommeVerser,
            "date_versement": versement.dateVersement,
            "id_secteur": versement.idSecteur,
            "id_chef_secteur": versement.idChefSecteur,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      print(data.body);
      if (data.statusCode > 202) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        echecTransaction(
            "Erreur lors de la création. ${response['message']}", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  addCharge(
      {String? token,
      ChargeModels? charge,
      required BuildContext? context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);

      var data = await http.post(host.baseUrl(endpoint: "charge/store"),
          headers: host.headers(token!),
          body: {
            "designation_charge": charge!.designationCharge,
            "description_charge": charge.descriptionCharge,
            "date_charge": charge.dateCharge,
            "somme_verser": charge.sommeCharge
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      print(data.body);
      if (data.statusCode > 202) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        echecTransaction(
            "Erreur lors de la création. ${response['message']}", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        Provider.of<HomeProvider>(context, listen: false).provideCharge();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  addMessageMois(
      {String? token,
      MessageMoisModel? messageMois,
      required BuildContext? context}) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);

      var data = await http.post(host.baseUrl(endpoint: "message-mois/store"),
          headers: host.headers(token!),
          body: {
            "designation_message": messageMois!.designationMessageMois,
            "corps_message": messageMois.corpsMessageMois,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      print(data.body);
      if (data.statusCode > 202) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        echecTransaction(
            "Erreur lors de la création. ${response['message']}", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        Provider.of<HomeProvider>(context, listen: false)
            .provideListMessageMoi();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      print(e);
    }
  }

  addMateriel({
    String? token,
    MaterielModels? materiel,
    required BuildContext? context,
  }) async {
    try {
      simpleDialogueCardSansTitle(
          msg: "Patientez svp...", context: context!, barrierDismissible: true);

      var request = http.MultipartRequest(
          "POST", host.baseUrl(endpoint: "materiel/store"));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['designation_materiel'] = materiel!.designationMateriel;
      request.fields['prix_materiel'] = materiel.prixMateriel;
      request.fields['date_achat_materiel'] = materiel.dateAchatMateriel;
      request.fields['statut_materiel'] = 'token';
      var imageMateriel = await http.MultipartFile.fromPath(
          "image_materiel", materiel.imageMateriel);
      var factureMateriel = await http.MultipartFile.fromPath(
          "facture_materiel", materiel.factureMateriel);
      request.files.add(imageMateriel);
      request.files.add(factureMateriel);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        succesTransaction("Ajout matériel effectué", context);
        // ignore: use_build_context_synchronously
        Provider.of<HomeProvider>(context, listen: false).provideMateriels();
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        echecTransaction("Echec ajout matériel", context);
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
        echecTransaction("Erreur lors du. ${response['message']}", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
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

      var data = await dio.postUri(host.baseUrl(endpoint: "code/get-code"),
          options: Options(headers: host.headers(token!)),
          data: {"code_admin": code, "id_admin": idAmin});

      if (data.statusCode == 200) {
        Navigator.pop(context);
        if (data.data['statut']) {
          Navigator.pop(context);
          return data.data['statut'];
        } else {
          echecTransaction(data.data['message'], context);
          return data.data['statut'];
        }
      }
    } catch (e) {
      print("code $e");
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

  deleteMateriel(
      {MaterielModels? materiel, String? token, required var context}) async {
    try {
      var data = await http.post(host.baseUrl(endpoint: "materiel/destroy"),
          headers: host.headers(token!),
          body: {
            "id": materiel!.id.toString(),
            "designation_materiel": materiel.designationMateriel.toString(),
            "prix_materiel": materiel.prixMateriel.toString(),
            "date_achat_materiel": materiel.dateAchatMateriel.toString(),
            "created_at": materiel.createAt.toString()
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

  deletePannes(
      {PannesModels? pannes, String? token, required var context}) async {
    try {
      var data = await dio.postUri(host.baseUrl(endpoint: "pannes/destroy"),
          options: Options(headers: host.headers(token!)),
          data: {
            "id": pannes!.id.toString(),
            "designation": pannes.designation.toString(),
            "description": pannes.description.toString(),
            "detected_date": pannes.detectedDate.toString(),
            "secteur": pannes.secteur.toString(),
          });

      if (data.statusCode == 200) {
        if (data.data['statut']) {
          succesTransaction(data.data['message'], context);
          Provider.of<HomeProvider>(context, listen: false).providePannes();
          return data.data['statut'];
        } else {
          echecTransaction(data.data['message'], context);
          return data.data['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  deleteMessageMois(
      {MessageMoisModel? message, String? token, required var context}) async {
    try {
      var data = await dio.postUri(host.baseUrl(endpoint: "pannes/destroy"),
          options: Options(headers: host.headers(token!)),
          data: {"id": message!.id.toString()});

      if (data.statusCode == 200) {
        if (data.data['statut']) {
          succesTransaction(data.data['message'], context);
          Provider.of<HomeProvider>(context, listen: false).providePannes();
          return data.data['statut'];
        } else {
          echecTransaction(data.data['message'], context);
          return data.data['statut'];
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteVersement(
      {VersementModels? versement, String? token, required var context}) async {
    try {
      var data = await dio.postUri(host.baseUrl(endpoint: "versement/destroy"),
          options: Options(headers: host.headers(token!)),
          data: {
            "id": versement!.id.toString(),
            "nom_secteur": versement.nomSecteur,
            "nom_chef_secteur": versement.nomChefSecteur,
            "somme_verser": versement.sommeVerser.toString(),
            "date_versement": versement.dateVersement.toString(),
            "id_secteur": versement.idSecteur.toString(),
            "id_chef_secteur": versement.idChefSecteur.toString(),
          });

      if (data.statusCode == 200) {
        if (data.data['statut']) {
          succesTransaction(data.data['message'], context);
          Provider.of<HomeProvider>(context, listen: false).provideVersements();
          return data.data['statut'];
        } else {
          echecTransaction(data.data['message'], context);
          return data.data['statut'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  deleteCharge(
      {ChargeModels? charge, String? token, required var context}) async {
    try {
      var data = await dio.postUri(host.baseUrl(endpoint: "charge/destroy"),
          options: Options(headers: host.headers(token!)),
          data: {
            "id": charge!.id.toString(),
            "designation_charge": charge.designationCharge,
            "description_charge": charge.descriptionCharge,
            "date_charge": charge.dateCharge,
            "somme_verser": charge.sommeCharge
          });

      if (data.statusCode == 200) {
        if (data.data['statut']) {
          succesTransaction(data.data['message'], context);
          Provider.of<HomeProvider>(context, listen: false).provideCharge();
          return data.data['statut'];
        } else {
          echecTransaction(data.data['message'], context);
          return data.data['statut'];
        }
      }
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
        debugPrint(response.toString());
        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);

        succesTransaction(response['message'], context);
      }
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
        var response = jsonDecode(data.body);
        return response['type_abonnement'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getListMateriel({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "materiel/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);

        return response['materiel'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getListVersement({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "versement/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);

        return response['versement'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getListCharge({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "charge/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);

        return response['charges'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getListMessageMois({String? token}) async {
    try {
      var data = await http
          .get(host.baseUrl(endpoint: "message-mois/index"),
              headers: host.headers(token!))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);
        return response['message'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getListPannes({String? token}) async {
    try {
      var data = await dio.getUri(host.baseUrl(endpoint: "pannes/index"),
          options: Options(headers: host.headers(token!)));
      if (data.statusCode! > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return data.data['pannes'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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
        debugPrint(response.toString());

        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);

        succesTransaction(response['message'], context);
      }
    } catch (e) {
      debugPrint(e.toString());
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
        debugPrint(response.toString());

        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        var response = await jsonDecode(data.body);
        Navigator.pop(context);
        succesTransaction(response['message'], context);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getAddPanne({
    String? token,
    PannesModels? panne,
    required var context,
  }) async {
    try {
      simpleDialogueCardSansTitle(
        msg: "Patientez svp...",
        context: context!,
        barrierDismissible: true,
      );
      var data = await dio.postUri(host.baseUrl(endpoint: "pannes/store"),
          options: Options(headers: host.headers(token!)),
          data: {
            'designation': panne!.designation,
            'description': panne.description,
            'detected_date': panne.detectedDate,
            'secteur': panne.secteur,
          });
      if (data.statusCode! > 300) {
        Navigator.pop(context);
        echecTransaction("Erreur lors de la création.", context);
      }
      if (data.statusCode == 200) {
        Navigator.pop(context);
        succesTransaction(data.data['message'], context);
      }
    } catch (e) {
      debugPrint(e.toString());
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
        var response = jsonDecode(data.body);
        return response['abonne'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getListFacture({String? token, required Users? users}) async {
    try {
      var data = await dio.postUri(host.baseUrl(endpoint: "facture/index"),
          data: {
            'id_chef_secteur': users!.id.toString(),
            'role_utilisateur': users.roleUtilisateur.toString()
          },
          options: Options(headers: host.headers(token!)));

      if (data.statusCode! > 300) {
        return [];
      }
      if (data.statusCode == 200) {
        return data.data;
      }
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
    }
  }
}
