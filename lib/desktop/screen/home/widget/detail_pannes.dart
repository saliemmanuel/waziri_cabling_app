import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_detail_widget.dart';
import 'package:waziri_cabling_app/models/pannes_models.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/users.dart';
import '../provider/home_provider.dart';

class DetailPannes extends StatefulWidget {
  final PannesModels pannes;
  final Users users;

  const DetailPannes({super.key, required this.pannes, required this.users});

  @override
  State<DetailPannes> createState() => _DetailPannesState();
}

class _DetailPannesState extends State<DetailPannes> {
  late TextEditingController designation;
  late TextEditingController description;
  late String secteur;
  bool? isActive = false;
  PannesModels? _pannesModels;

  @override
  void initState() {
    designation = TextEditingController(text: widget.pannes.designation);
    description = TextEditingController(text: widget.pannes.description);
    secteur = widget.pannes.secteur;
    initListSecteur();
    super.initState();
  }

  List? listSecteur = [];

  initListSecteur() async {
    List list =
        await Provider.of<HomeProvider>(context, listen: false).listSecteur;
    if (list != []) {
      for (var i = 0; i < list.length; i++) {
        if (widget.users.roleUtilisateur == 'admin') {
          listSecteur!.add(
              '${list[i]['designation_secteur']} - ${list[i]['nom_chef_secteur']} - ${list[i]['id_chef_secteur']}');
        } else {
          if (list[i]['id_chef_secteur'] == widget.users.id) {
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
          width: 800.0,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomText(
                        data: "Détail panne",
                        color: Colors.red,
                        fontSize: 30.0),
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDetailWidget2(
                                    title: "Désignation panne",
                                    controller: designation,
                                    onChanged: (value) {
                                      valueIsChange();
                                    }),
                                CustomDetailWidget2(
                                    title: "Description panne",
                                    controller: description,
                                    onChanged: (value) {
                                      valueIsChange();
                                    }),
                              ]),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: Column(
                          children: [
                            CustomDetailWidget(
                              title: "Date détection panne",
                              nullVal: widget.pannes.detectedDate,
                              subtitle: selectedJourDate,
                              onTap: () {
                                valueIsChange();
                                _selectDate(context);
                              },
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 10.0, bottom: 10.0),
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
              ))),
        ));
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
        valueIsChange();
      });
    }
  }

  valueIsChange() {
    _pannesModels = PannesModels(
        id: widget.pannes.id,
        designation: designation.text,
        description: description.text,
        detectedDate: selectedJourDate ?? widget.pannes.detectedDate,
        secteur: secteur);
    if (_pannesModels.toString() != widget.pannes.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}
