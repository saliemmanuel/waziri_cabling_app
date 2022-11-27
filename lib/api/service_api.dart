import 'dart:async';
import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';

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

  // inscription
  getSingIn({String? email, String? mdp, var context}) async {
    try {
      simpleDialogueCardSansTitle("Patientez svp ...", context);
      var data = await http.post(host.baseUrl(endpoint: 'kldks'), body: {
        "key": 'fifete',
        'service': 'inscription',
        "mdp_utilisateur": mdp,
        "grade_utilisateur": 'internaute'
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'Connexion perdue, verifier votre connexion internet');
      });
      if (data.statusCode == 200) {
        var response = jsonDecode(data.body);
        if (response['error'] == '0') {
        } else {
          Navigator.pop(context);
          errorDialogueCard("Erreur !", "${response['message']}", context);
        }
      }
    } catch (e) {
      errorDialogueCard("Erreur !", "$e", context)
          .then((value) => Navigator.pop(context));
    }
  }

  // inscription
  connexion({String? email, String? password, var context}) async {
    dynamic response;
    try {
      simpleDialogueCardSansTitle("Patientez svp ...", context);
      if (isEmail(email!)) {
        var data = await http.post(
            host.baseUrl(endpoint: "utilisateur/connexion"),
            headers: host.headers,
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
          print(Provider.of<AuthProvider>(context, listen: false).userIsLogged);

          return true;
        }
      } else {
        echecTransaction("Entrez un e-mail valide", context!);
      }
    } catch (e) {
      errorDialogueCard("Erreur !", "$e", context)
          .then((value) => Navigator.pop(context));
      return false;
    }
  }
}
