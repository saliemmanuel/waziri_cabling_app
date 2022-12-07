import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/users.dart';

class AddNewUser extends StatefulWidget {
  final Users users;
  const AddNewUser({super.key, required this.users});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  List? listSecteur = [
    'Maroua',
    'Douala',
    'Yaoundé ',
    'Bamenda',
    'Ngaoundéré',
    'Loum',
    'Nkongsamba',
  ];
  List? listRole = ['Admin', 'chef-secteur'];
  var role = "Rôle utilisateur";
  var secteur = "Selectionner un secteur";
  var name = TextEditingController();
  var secondname = TextEditingController();
  var email = TextEditingController();
  var telephone = TextEditingController();
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
                        Provider.of<HomeProvider>(context, listen: false)
                            .addNewUser(
                                users: Users(
                                  id: null,
                                  nomUtilisateur: name.text,
                                  prenomUtilisateur: secondname.text,
                                  roleUtilisateur: role,
                                  telephoneUtilisateur:
                                      telephone.text.toString(),
                                  zoneUtilisateur: secteur,
                                  idUtilisateurInitiateur: widget.users.id,
                                  email: email.text,
                                ),
                                context: context);
                        Provider.of<HomeProvider>(context, listen: false)
                            .providelistUtilisateur();
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
