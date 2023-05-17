import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';
import 'package:waziri_cabling_app/models/versement_models.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../provider/home_provider.dart';

class AddVersement extends StatefulWidget {
  const AddVersement({super.key});

  @override
  State<AddVersement> createState() => _AddVersementState();
}

class _AddVersementState extends State<AddVersement> {
  var somme = TextEditingController();
  dynamic selectedDate;
  final List? listSecteur = [];
  String? secteur = "Selectionner un secteur";
  String? idSecteur = "";
  String? idChefSecteur = "";
  dynamic nomChefSecteur;

  @override
  void initState() {
    initListSecteur();
    super.initState();
  }

  initListSecteur() async {
    dynamic list =
        await Provider.of<HomeProvider>(context, listen: false).listSecteur;
    if (list != []) {
      for (var i = 0; i < list.length; i++) {
        listSecteur!.add(
            '${list[i]['designation_secteur']} - ${list[i]['nom_chef_secteur']} - ${list[i]['id_chef_secteur']} - ${list[i]['id']}');
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
          Provider.of<HomeProvider>(context, listen: false).provideVersements();
        },
      ),
      child: SizedBox(
        width: 850.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Ajout versement", color: Colors.red, fontSize: 30.0),
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
                                child: CustomText(data: "Désignation secteur")),
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
                                    child: Text(secteur.toString(),
                                        style: const TextStyle(
                                            color: Colors.black)),
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
                                    nomChefSecteur =
                                        newSecteur.toString().split('-')[1];
                                    idChefSecteur =
                                        newSecteur.toString().split('-')[2];
                                    idSecteur =
                                        newSecteur.toString().split('-')[3];
                                    setState(() {});
                                  }),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Somme verser")),
                          ),
                          CustumTextField(
                              child: 'Somme',
                              controller: somme,
                              obscureText: false),
                          const SizedBox(height: 100.0)
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomDetailWidget(
                            title: "Nom chef secteur",
                            nullVal: "Nom chef secteur",
                            subtitle: nomChefSecteur,
                          ),
                          const SizedBox(height: 10.0),
                          CustomDetailWidget(
                            title: "Date versement",
                            nullVal: "Date",
                            subtitle: selectedDate,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          const SizedBox(height: 100.0)
                        ],
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
                          if (nomChefSecteur != null ||
                              secteur != "Selectionner un secteur" ||
                              selectedDate != null ||
                              somme.text.isNotEmpty) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .addVersement(
                                    versement: VersementModels(
                                        id: "",
                                        nomSecteur: secteur!,
                                        nomChefSecteur: nomChefSecteur,
                                        dateVersement: selectedDate,
                                        idSecteur: idSecteur!,
                                        idChefSecteur: idChefSecteur!,
                                        sommeVerser: somme.text.toString()),
                                    context: context);
                            Provider.of<HomeProvider>(context, listen: false)
                                .provideVersements();
                          } else {
                            echecTransaction(
                                "Remplissez tous les champ svp!", context);
                          }
                        }),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
                        bacgroundColor: Palette.red,
                        onPressed: () async {
                          Navigator.pop(context);
                          Provider.of<HomeProvider>(context, listen: false)
                              .provideMateriels();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = '${picked.day}-${picked.month}-${picked.year} ';
      });
    }
  }
}
