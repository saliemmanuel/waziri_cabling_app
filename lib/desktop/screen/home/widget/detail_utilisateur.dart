import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/config/config.dart';

import '../../../../global_widget/custom_button.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../models/users.dart';

class DetailUtilisateur extends StatefulWidget {
  final Users users;
  const DetailUtilisateur({super.key, required this.users});

  @override
  State<DetailUtilisateur> createState() => _DetailUtilisateurState();
}

class _DetailUtilisateurState extends State<DetailUtilisateur> {
  List? listRole = ['admin', 'chef-secteur'];
  String? role;
  Users? _users;
  bool? isActive = false;
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

  late TextEditingController nom;
  late TextEditingController prenom;
  late TextEditingController email;
  late TextEditingController telephone;

  @override
  void initState() {
    secteur = widget.users.zoneUtilisateur;
    role = widget.users.roleUtilisateur;
    nom = TextEditingController(text: widget.users.nomUtilisateur);
    prenom = TextEditingController(text: widget.users.prenomUtilisateur);
    email = TextEditingController(text: widget.users.email!);
    telephone = TextEditingController(text: widget.users.telephoneUtilisateur!);
    debugPrint(widget.users.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
        largeSize: 30,
        smallSize: 50,
        label: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800.0,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                      data: "Détail utilisateur",
                      color: Colors.red,
                      fontSize: 30.0),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDetailWidget2(
                                  title: "Nom utilisateur",
                                  controller: nom,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              CustomDetailWidget2(
                                  title: "E-mail",
                                  controller: email,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              CustomDetailWidget2(
                                  title: "Téléphone",
                                  controller: telephone,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                            ]),
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                          child: Column(
                        children: [
                          CustomDetailWidget2(
                              title: "Prénom utilisateur",
                              controller: prenom,
                              onChanged: (value) {
                                valueIsChange();
                              }),
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
                                    valueIsChange();
                                    setState(() {});
                                  }),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Ville")),
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
                                    valueIsChange();

                                    setState(() {});
                                  }),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustumButton(
                        bacgroundColor: isActive! ? Palette.teal : Colors.grey,
                        enableButton: isActive,
                        child: "  Enregistrez  ",
                        onPressed: () {},
                      ),
                      CustumButton(
                          enableButton: true,
                          child: "   Fermer   ",
                          bacgroundColor: Palette.red,
                          onPressed: () async {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ],
              ))),
        ));
  }

  valueIsChange() {
    _users = Users(
        id: widget.users.id,
        email: email.text,
        nomUtilisateur: nom.text,
        prenomUtilisateur: prenom.text,
        roleUtilisateur: role,
        telephoneUtilisateur: telephone.text,
        zoneUtilisateur: secteur,
        idUtilisateurInitiateur: widget.users.idUtilisateurInitiateur);
    if (_users.toString() != widget.users.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}
