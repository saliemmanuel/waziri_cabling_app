import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_detail_widget_2.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/users.dart';
import '../provider/home_provider.dart';

class DetailAbonne extends StatefulWidget {
  final AbonneModels abonne;
  final Users users;

  const DetailAbonne({super.key, required this.abonne, required this.users});

  @override
  State<DetailAbonne> createState() => _DetailAbonneState();
}

class _DetailAbonneState extends State<DetailAbonne> {
  String? type;
  String? secteur;
  String? idChefSecteur;
  String? idType;
  List? listTypeAbonnement = [];
  List? listSecteur = [];
  late TextEditingController nom;
  late TextEditingController prenom;
  late TextEditingController cni;
  late TextEditingController descriptionZone;
  late TextEditingController telephone;
  bool? isActive = false;
  AbonneModels? _abonneModels;

  @override
  void initState() {
    initListSecteur();
    initListTypeAbonnement();
    nom = TextEditingController(text: widget.abonne.nomAbonne);
    prenom = TextEditingController(text: widget.abonne.prenomAbonne);
    cni = TextEditingController(text: widget.abonne.cniAbonne);
    descriptionZone =
        TextEditingController(text: widget.abonne.descriptionZoneAbonne);
    telephone = TextEditingController(text: widget.abonne.telephoneAbonne);
    type = widget.abonne.typeAbonnement;
    secteur = widget.abonne.secteurAbonne;
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
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                      data: "Détail Abonné", color: Colors.red, fontSize: 30.0),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDetailWidget2(
                                  title: "Nom abonné",
                                  controller: nom,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              CustomDetailWidget2(
                                  title: "Prénom abonné",
                                  controller: prenom,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              CustomDetailWidget2(
                                  title: "cni abonné",
                                  controller: cni,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              CustomDetailWidget2(
                                  title: "Téléphone abonné",
                                  controller: telephone,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                            ]),
                      ),
                      const SizedBox(width: 25.0),
                      Expanded(
                        child: Column(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 10.0, bottom: 10.0),
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
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
                                      valueIsChange();
                                      setState(() {});
                                    }),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 10.0, bottom: 10.0),
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
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
                                      valueIsChange();

                                      setState(() {});
                                    }),
                              ),
                            ),
                            CustomDetailWidget2(
                                title: "Description zône abonné",
                                controller: descriptionZone,
                                onChanged: (value) {
                                  valueIsChange();
                                }),
                            const SizedBox(height: 40.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustumButton(
                                  bacgroundColor:
                                      isActive! ? Palette.teal : Colors.grey,
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
                        ),
                      )
                    ],
                  ),
                ],
              ))),
        ));
  }

  valueIsChange() {
    _abonneModels = AbonneModels(
        id: widget.abonne.id,
        nomAbonne: nom.text,
        prenomAbonne: prenom.text,
        cniAbonne: cni.text,
        telephoneAbonne: telephone.text,
        descriptionZoneAbonne: descriptionZone.text,
        secteurAbonne: secteur ?? widget.abonne.secteurAbonne,
        idChefSecteur: idChefSecteur ?? widget.abonne.idChefSecteur,
        typeAbonnement: type ?? widget.abonne.typeAbonnement,
        idTypeAbonnement: idType ?? widget.abonne.idTypeAbonnement);
    if (_abonneModels.toString() != widget.abonne.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}
