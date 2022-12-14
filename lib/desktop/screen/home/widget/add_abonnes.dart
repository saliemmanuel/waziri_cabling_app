import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class AddBonnes extends StatefulWidget {
  const AddBonnes({super.key});

  @override
  State<AddBonnes> createState() => _AddBonnesState();
}

class _AddBonnesState extends State<AddBonnes> {
  List? listSecteur = [
    'Maroua',
    'Douala',
    'Yaoundé ',
    'Bamenda',
    'Ngaoundéré',
    'Loum',
    'Nkongsamba',
  ];
  List? listRole = ['admin', 'chef-secteur'];
  var role = "Rôle utilisateur";
  var secteur = "Selectionner un secteur";
  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      child: SizedBox(
        width: 750.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
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
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Prénom utilisateur")),
                          ),
                          CustumTextField(
                              child: 'Prénom utilisateur', obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "E-mail")),
                          ),
                          CustumTextField(child: "E-mail", obscureText: false),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Téléphone")),
                          ),
                          CustumTextField(
                              child: "Téléphone", obscureText: false),
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
                                border:
                                    Border.all(color: Palette.primaryColor)),
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
                                border:
                                    Border.all(color: Palette.primaryColor)),
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
                    )
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
                          // Provider.of<HomeProvider>(context, listen: false)
                          //     .addNewUser(
                          //         users: Users(
                          //           id: null,
                          //           nomUtilisateur: name.text,
                          //           prenomUtilisateur: secondname.text,
                          //           roleUtilisateur: role,
                          //           telephoneUtilisateur:
                          //               telephone.text.toString(),
                          //           zoneUtilisateur: secteur,
                          //           idUtilisateurInitiateur: widget.users.id,
                          //           email: email.text,
                          //         ),
                          //         context: context);
                          // name.clear();
                          // secondname.clear();
                          // email.clear();
                          // telephone.clear();
                          // role = "Rôle utilisateur";
                          // secteur = "Selectionner un secteur";
                          // setState(() {});
                          // Provider.of<HomeProvider>(context, listen: false)
                          //     .providelistUtilisateur();
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
      ),
    );
  }
}
