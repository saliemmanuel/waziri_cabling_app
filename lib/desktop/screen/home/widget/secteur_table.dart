import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/add_secteur.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/models/secteur.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import 'action_dialogue.dart';
import 'add_new_user.dart';
import 'detail_seteur.dart';

class SecteurTable extends StatelessWidget {
  final listSecteur;
  const SecteurTable({super.key, required this.listSecteur});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
              CustomText(
                  data: "Liste des secteurs (${listSecteur.length ?? ""})"),
              const SizedBox(width: 70.0),
              Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 230.0,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search", border: InputBorder.none),
                )),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.teal),
                      CustomText(
                        data: "Ajoutez un secteur",
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(context: context, child: const AddSecteur());
                },
              ),
            ],
          ),
          const Divider(),
          Expanded(
              child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: CustomText(data: "N°")),
                DataColumn(label: CustomText(data: "Désignation secteur")),
                DataColumn(label: CustomText(data: "Description zône secteur")),
                DataColumn(label: CustomText(data: "Action")),
              ],
              rows: [
                for (var id = 0; id < listSecteur.length; id++)
                  DataRow(
                      color: id % 2 == 0
                          ? MaterialStateProperty.all(
                              Colors.grey.withOpacity(0.1))
                          : MaterialStateProperty.all(Colors.white),
                      cells: [
                        DataCell(CustomText(data: "${id + 1}")),
                        DataCell(CustomText(
                            data: listSecteur[id]['designation_secteur'])),
                        DataCell(CustomText(
                            data: listSecteur[id]['description_secteur'])),
                        DataCell(Row(children: [
                          Expanded(
                            child: MaterialButton(
                                color: Colors.teal,
                                child: const Icon(IconlyBold.edit,
                                    color: Colors.white),
                                onPressed: () {}),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Palette.online,
                                child: const CustomText(
                                    data: "Détail", color: Colors.white),
                                onPressed: () async {
                                  actionDialogue(
                                      child: DetailSecteur(
                                        secteur: Secteur(
                                            id: listSecteur[id]['id'],
                                            descriptionSecteur: listSecteur[id]
                                                ['description_secteur'],
                                            designationSecteur: listSecteur[id]
                                                ['designation_secteur']),
                                      ),
                                      context: context);
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Colors.red,
                                child: const Icon(IconlyBold.delete,
                                    color: Colors.white),
                                onPressed: () async {
                                  // var res = getCodeAuth(context);
                                }),
                          ),
                        ])),
                      ]),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
