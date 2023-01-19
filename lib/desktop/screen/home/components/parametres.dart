import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/users.dart';
import '../widget/action_dialogue.dart';
import '../widget/edite_user.dart';

class Parametres extends StatefulWidget {
  final Users? users;
  const Parametres({super.key, required this.users});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  var code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 45.0, right: 45.0),
              child: AppBar(
                title:
                    const CustomText(data: "Paramètres", color: Colors.black),
                elevation: 0.0,
                backgroundColor: Palette.scaffold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0)),
              child: Column(
                children: [
                  ListTile(title: Text(user.email.toString())),
                  ListTile(title: Text(user.nomUtilisateur.toString())),
                  ListTile(title: Text(user.prenomUtilisateur.toString())),
                  ListTile(title: Text(user.roleUtilisateur.toString())),
                  ListTile(title: Text(user.telephoneUtilisateur.toString())),
                  ListTile(title: Text(user.zoneUtilisateur.toString())),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 375.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: CustumTextField(
                                child: "Code",
                                obscureText: true,
                                controller: code,
                              ),
                            ),
                          ),
                          CustumButton(
                            enableButton: true,
                            child: "   Enregistrez   ",
                            bacgroundColor: Colors.teal,
                            onPressed: () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .getInsertAdministrationCode(
                                      idUser: widget.users!.id.toString(),
                                      codeAdmin: code.text,
                                      context: context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: const Text("Edite"),
                    onTap: () {
                      actionDialogue(
                          child: EditeUser(userData: widget.users!),
                          context: context);
                      // Provider.of<HomeProvider>(context, listen: false)
                      //     .updateUtilisateur(
                      //   users: Users(),
                      //   context: context,
                      // );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 50.0),
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Icon(Icons.logout),
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false)
                .logout(context: context);
          },
        ),
      ),
    );
  }
}
