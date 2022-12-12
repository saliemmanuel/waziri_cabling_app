import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../global_widget/custom_dropdow.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class EditeUser extends StatefulWidget {
  final dynamic userData;
  const EditeUser({super.key, required this.userData});

  @override
  State<EditeUser> createState() => _EditeUserState();
}

class _EditeUserState extends State<EditeUser> {
  List? listSecteur = [
    'Maroua',
    'Douala',
    'Yaoundé ',
    'Bamenda',
    'Ngaoundéré',
    'Loum',
    'Nkongsamba',
  ];

  String? secteur;
  TextEditingController? name;
  TextEditingController? secondname;
  TextEditingController? email;
  TextEditingController? telephone;
  List? listRole = ['admin', 'chef-secteur'];
  String? role;
  @override
  void initState() {
    secteur = widget.userData['zone_utilisateur'];
    name = TextEditingController(text: widget.userData['nom_utilisateur']);
    secondname =
        TextEditingController(text: widget.userData['prenom_utilisateur']);
    email = TextEditingController(text: widget.userData["email"].toString());
    telephone = TextEditingController(
        text: widget.userData["telephone_utilisateur"].toString());
    role = widget.userData["role_utilisateur"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(data: "Nom utilisateur")),
                  ),
                  CustumTextField(
                      bacgroundColor: Palette.teal,
                      child: 'Nom utilisateur',
                      controller: name,
                      obscureText: false),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(data: "Prénom utilisateur")),
                  ),
                  CustumTextField(
                      child: 'Prénom utilisateur',
                      controller: secondname,
                      obscureText: false),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(data: "E-mail")),
                  ),
                  CustumTextField(
                      child: "E-mail", controller: email, obscureText: false),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(data: "Téléphone")),
                  ),
                  CustumTextField(
                      child: "Téléphone",
                      controller: telephone,
                      obscureText: false),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(data: "Rôle")),
                  ),
                  Container(
                    height: 55.5,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Palette.primaryColor)),
                    child: Center(
                      child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(role.toString()),
                          ),
                          dropdownColor: Colors.white,
                          items: listRole!
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ))
                              .toList(),
                          onChanged: (newVille) {
                            role = newVille!;
                            setState(() {});
                          }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(data: "Secteur")),
                  ),
                  Container(
                    height: 55.5,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Palette.primaryColor)),
                    child: Center(
                      child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(secteur.toString()),
                          ),
                          dropdownColor: Colors.white,
                          items: listSecteur!
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ))
                              .toList(),
                          onChanged: (newVille) {
                            secteur = newVille!;
                            setState(() {});
                          }),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustumButton(
                      enableButton: true,
                      child: "   Enregistrez   ",
                      bacgroundColor: Palette.teal,
                      onPressed: () async {
                       
                      }),
                  CustumButton(
                      enableButton: true,
                      child: "   Annuler   ",
                      bacgroundColor: Palette.red,
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
