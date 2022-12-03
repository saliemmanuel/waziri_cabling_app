import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';

import 'widget.dart';

Future simpleDialogueCard(String title, String msg, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 15.0),
              Text(msg)
            ],
          ),
        );
      });
}

Future simpleDialogueCardSansTitle(String msg, BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(color: Palette.primaryColor),
              const SizedBox(width: 15.0),
              Text(msg)
            ],
          ),
        );
      });
}

Future errorDialogueCard(String title, String msg, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: CustumButton(
                enableButton: true,
                child: "Ok",
                enableBorder: false,
                borderRadius: 8.0,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      });
}

Future echecTransaction(String msg, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.0),
              CircleAvatar(
                backgroundColor: Colors.red.withOpacity(0.3),
                radius: 30.0,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 50.0,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(msg),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: CustumButton(
                enableButton: true,
                child: "Ok",
                enableBorder: false,
                borderRadius: 8.0,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      });
}

Future succesTransaction(String msg, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.withOpacity(0.3),
                radius: 30.0,
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 50.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(msg),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: CustumButton(
                enableButton: true,
                child: "Ok",
                enableBorder: false,
                borderRadius: 8.0,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      });
}

Future getCodeAuth(BuildContext context) {
  return showDialog(
      //
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entrez le Code de vérification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustumTextField(child: "Code", obscureText: true),
              Row(
                children: [
                  Expanded(
                    child: CustumButton(
                        enableButton: true,
                        bacgroundColor: Palette.teal,
                        child: "Valider",
                        onPressed: () {
                          Navigator.pop(context, "Valider");
                        }),
                  ),
                  Expanded(
                    child: CustumButton(
                        enableButton: true,
                        bacgroundColor: Colors.red,
                        child: "Annuler",
                        onPressed: () {
                          Navigator.pop(context, "Annuler");
                        }),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
