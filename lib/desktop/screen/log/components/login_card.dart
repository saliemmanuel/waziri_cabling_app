import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/global_widget/widget.dart';

import '../../home/home_desk_screen.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool checked = false;
  var emailTextEditing = TextEditingController(text: "admin@gmail.com");
  var passTextEditing = TextEditingController(text: "admin");
  var auth = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
              data: "Login To DeskApp",
              color: Palette.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 30.0),
          const SizedBox(height: 35.0),
          CustumTextField(
            child: "E-mail",
            obscureText: false,
            controller: emailTextEditing,
          ),
          CustumTextField(
              child: "Mot de passe",
              obscureText: true,
              controller: passTextEditing),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ToggleSwitch(
                checked: checked,
                content: const Text("Garder ma session active"),
                onChanged: (bool value) {
                  setState(() => checked = value);
                },
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          CustumButton(
              enableButton: true,
              child:
                  "Se connecter ${Provider.of<AuthProvider>(context).userIsLogged}",
              onPressed: () async {
                if (emailTextEditing.text.isEmpty ||
                    passTextEditing.text.isEmpty) {
                  errorDialogueCard(
                      "Erreur", "Entrez un E-mail et mot de passe.", context);
                } else {
                  Provider.of<AuthProvider>(context, listen: false).connexion(
                      email: emailTextEditing.text,
                      password: passTextEditing.text,
                      context: context);
                }
              }),
          const Spacer(),
        ],
      ),
    );
  }
}
