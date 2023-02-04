import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/pannes_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class AddPannes extends StatefulWidget {
  final Users users;
  const AddPannes({super.key, required this.users});

  @override
  State<AddPannes> createState() => _AddPannesState();
}

class _AddPannesState extends State<AddPannes> {
  List? _listSecteur = [];
  var secteur = "Selectionner un secteur";
  var designation = TextEditingController();
  var description = TextEditingController();

  @override
  void initState() {
    initListSecteur();
    super.initState();
  }

  initListSecteur() async {
    List list =
        await Provider.of<HomeProvider>(context, listen: false).listSecteur;

    if (list != []) {
      for (var i = 0; i < list.length; i++) {
        if (widget.users.roleUtilisateur == 'admin') {
          _listSecteur!.add(
              '${list[i]['designation_secteur']} - ${list[i]['nom_chef_secteur']} - ${list[i]['id_chef_secteur']}');
        } else {
          if (list[i]['id_chef_secteur'] == widget.users.id) {
            _listSecteur!.add(
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
      badgeContent: InkWell(
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
                    data: "Ajout pannes", color: Colors.red, fontSize: 30.0),
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
                                child: CustomText(data: "Désigantion panne")),
                          ),
                          CustumTextField(
                              bacgroundColor: Palette.teal,
                              controller: designation,
                              child: 'Désignation',
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Description panne")),
                          ),
                          CustumTextField(
                              controller: description,
                              child: "Description",
                              obscureText: false),
                          CustomDetailWidget(
                            title: "Jour détection panne",
                            nullVal: "Date",
                            subtitle: selectedJourDate,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
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
                                  items: _listSecteur!
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
                                    setState(() {});
                                  }),
                            ),
                          ),
                          const SizedBox(height: 200.0)
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
                          if (designation.text.isEmpty ||
                              description.text.isEmpty ||
                              selectedJourDate == null) {
                            errorDialogueCard("Erreur",
                                "Entrez toute les informations svp!", context);
                          } else {
                            Provider.of<HomeProvider>(context, listen: false)
                                .addPannes(
                                    panne: PannesModels(
                                      id: "",
                                      designation: designation.text,
                                      description: description.text,
                                      detectedDate: selectedJourDate,
                                      secteur: secteur,
                                    ),
                                    context: context);
                            designation.clear();
                            description.clear();
                            selectedJourDate = null;
                            secteur = "Selectionner un secteur";
                            Provider.of<HomeProvider>(context, listen: false)
                                .providePannes();
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
          ),
        ),
      ),
    );
  }

  dynamic selectedJourDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        textDirection: TextDirection.ltr,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedJourDate) {
      setState(() {
        selectedJourDate = '${picked.day}-${picked.month}-${picked.year} ';
      });
    }
  }
}
