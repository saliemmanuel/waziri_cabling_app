import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class AddBonnes extends StatefulWidget {
  final Users users;
  const AddBonnes({super.key, required this.users});

  @override
  State<AddBonnes> createState() => _AddBonnesState();
}

class _AddBonnesState extends State<AddBonnes> {
  var type = "Type abonnement";
  var secteur = "Selectionner un secteur";
  var idChefSecteur = "";
  var idType = "";
  List? listTypeAbonnement = [];
  List? listSecteur = [];
  var nom = TextEditingController();
  var prenom = TextEditingController();
  var cni = TextEditingController();
  var descriptionZone = TextEditingController();
  var telephone = TextEditingController();

  @override
  void initState() {
    initListSecteur();
    initListTypeAbonnement();
    super.initState();
  }

  initListTypeAbonnement() async {
    dynamic list = await Provider.of<HomeProvider>(context, listen: false)
        .listTypeAbonnement;
    if (list != []) {
      for (var i = 0; i < list.length; i++) {
        listTypeAbonnement!.add(
            '${list[i]['designation_type_abonnement']} - ${list[i]['id']}');
      }
    }
    setState(() {});
  }

  initListSecteur() async {
    dynamic list =
        await Provider.of<HomeProvider>(context, listen: false).listSecteur;
    if (list != []) {
      for (var i = 0; i < list.length; i++) {
        if (widget.users.roleUtilisateur == 'admin') {
          listSecteur!.add(
              '${list[i]['designation_secteur']} - ${list[i]['nom_chef_secteur']} - ${list[i]['id_chef_secteur']}');
        } else {
          if (list[i]['id_chef_secteur'].toString() ==
              widget.users.id.toString()) {
            listSecteur!.add(
                '${list[i]['designation_secteur']} - ${list[i]['nom_chef_secteur']} - ${list[i]['id_chef_secteur']}');
          }
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 30,
      smallSize: 50,
      label: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      child: SizedBox(
        width: 800.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Ajout Abonné", color: Colors.red, fontSize: 30.0),
                const SizedBox(height: 25.0),
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
                                child: CustomText(data: "Nom abonné")),
                          ),
                          CustumTextField(
                              bacgroundColor: Palette.teal,
                              controller: nom,
                              child: 'Nom abonné',
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Téléphone")),
                          ),
                          CustumTextField(
                              controller: telephone,
                              child: "Téléphone",
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "cni abonné")),
                          ),
                          CustumTextField(
                              controller: cni,
                              child: "cni abonné",
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                    data: "Description zône abonné")),
                          ),
                          CustumTextField(
                              controller: descriptionZone,
                              child: "Description",
                              obscureText: false),
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
                                child: CustomText(data: "Prénom abonné")),
                          ),
                          CustumTextField(
                              controller: prenom,
                              child: 'Prénom abonné',
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Type abonnement")),
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
                                    child: Text(type.toString()),
                                  ),
                                  dropdownColor: Colors.white,
                                  items: listTypeAbonnement!
                                      .map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(
                                                e.toString().split('-')[0],
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          ))
                                      .toList(),
                                  onChanged: (newType) {
                                    idType = newType.toString().split('-')[1];
                                    type = newType!.toString().split('-')[0];
                                    setState(() {});
                                  }),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Secteur abonné")),
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
                                            child: Text(
                                                e.toString().split('-')[0],
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          ))
                                      .toList(),
                                  onChanged: (newSecteur) {
                                    secteur =
                                        newSecteur!.toString().split('-')[0];
                                    idChefSecteur =
                                        newSecteur.toString().split('-')[2];
                                    setState(() {});
                                  }),
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustumButton(
                                  enableButton: true,
                                  child: "   Enregistrez   ",
                                  bacgroundColor: Palette.teal,
                                  onPressed: () async {
                                    if (nom.text.isEmpty ||
                                        prenom.text.isEmpty ||
                                        cni.text.isEmpty ||
                                        descriptionZone.text.isEmpty ||
                                        telephone.text.isEmpty) {
                                      errorDialogueCard(
                                          "Erreur",
                                          "Entrez toute les informations svp!",
                                          context);
                                    } else {
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .addAbonnes(
                                              abonne: AbonneModels(
                                                  id: "",
                                                  nomAbonne: nom.text,
                                                  prenomAbonne: prenom.text,
                                                  cniAbonne: cni.text,
                                                  telephoneAbonne:
                                                      telephone.text,
                                                  descriptionZoneAbonne:
                                                      descriptionZone.text,
                                                  secteurAbonne: secteur,
                                                  idChefSecteur: idChefSecteur,
                                                  typeAbonnement: type,
                                                  idTypeAbonnement: idType),
                                              context: context);
                                      nom.clear();
                                      prenom.clear();
                                      cni.clear();
                                      telephone.clear();
                                      descriptionZone.clear();
                                      type = "Type abonnement";
                                      secteur = "Selectionner un secteur";
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .provideListeAbonnes(
                                              users: widget.users);
                                    }
                                    setState(() {});
                                  }),
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
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
