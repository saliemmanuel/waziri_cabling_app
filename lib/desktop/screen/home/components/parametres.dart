import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';

import '../../../../api/service_api.dart';
import '../../../../config/config.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/users.dart';
import '../widget/action_dialogue.dart';
import '../widget/app_header.dart';
import '../widget/detail_utilisateur.dart';

class Parametres extends StatefulWidget {
  final Users? users;
  const Parametres({super.key, required this.users});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  var code = TextEditingController();
  Users? user;
  final _service = ServiceApi();

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    var storage = const FlutterSecureStorage();
    var token = await storage.read(key: 'tokens');
    var tmp = await _service.getListUtilisateur(token: token);
    var temp = tmp['utilisateur'] ?? [];
    if (temp != []) {
      for (var i in temp) {
        if (i['id'].toString() == widget.users!.id!.toString()) {
          user = Users(
            id: i['id'].toString(),
            email: i['email'].toString(),
            idUtilisateurInitiateur: i['id_utilisateur_initiateur'].toString(),
            nomUtilisateur: i['nom_utilisateur'].toString(),
            prenomUtilisateur: i['prenom_utilisateur'].toString(),
            roleUtilisateur: i['role_utilisateur'].toString(),
            telephoneUtilisateur: i['telephone_utilisateur'].toString(),
            zoneUtilisateur: i['zone_utilisateur'].toString(),
          );
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            appHeader("Paramètres"),
            Container(
              margin: const EdgeInsets.only(
                  left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0)),
              child: user == null
                  ? const Row(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : Column(
                      children: [
                        ListTile(title: Text(user!.nomUtilisateur.toString())),
                        ListTile(
                            title: Text(user!.prenomUtilisateur.toString())),
                        ListTile(title: Text(user!.email.toString())),
                        ListTile(
                            title: Text(user!.telephoneUtilisateur.toString())),
                        ListTile(title: Text(user!.zoneUtilisateur.toString())),
                        ListTile(title: Text(user!.roleUtilisateur.toString())),
                        Row(
                          children: [
                            CustumButton(
                              enableButton: true,
                              child: "   Editer   ",
                              bacgroundColor: Colors.teal,
                              onPressed: () {
                                actionDialogue(
                                    child: DetailUtilisateur(
                                      users: Users(
                                          id: user!.id.toString(),
                                          prenomUtilisateur:
                                              user!.prenomUtilisateur!,
                                          nomUtilisateur: user!.nomUtilisateur,
                                          roleUtilisateur:
                                              user!.roleUtilisateur,
                                          email: user!.email,
                                          telephoneUtilisateur: user!
                                              .telephoneUtilisateur
                                              .toString(),
                                          zoneUtilisateur:
                                              user!.zoneUtilisateur,
                                          idUtilisateurInitiateur: user!
                                              .idUtilisateurInitiateur
                                              .toString()),
                                    ),
                                    context: context);
                                initData();
                              },
                            ),
                          ],
                        ),
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
                                    Provider.of<HomeProvider>(context,
                                            listen: false)
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
