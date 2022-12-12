import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/add_secteur.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'action_dialogue.dart';
import 'add_new_user.dart';
import 'detail_seteur.dart';

class SecteurTable extends StatelessWidget {
  final listSecteur;
  final Users users;
  const SecteurTable(
      {super.key, required this.listSecteur, required this.users});

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
                  actionDialogue(
                      context: context, child: AddSecteur(users: users));
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
                DataColumn(label: CustomText(data: "Désignation")),
                DataColumn(label: CustomText(data: "Description")),
                DataColumn(label: CustomText(data: "Chef secteur")),
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
                        DataCell(Expanded(
                          child: CustomText(
                              data: listSecteur[id]['designation_secteur']),
                        )),
                        DataCell(CustomText(
                            data: listSecteur[id]['description_secteur'],
                            overflow: TextOverflow.clip)),
                        DataCell(CustomText(
                          data: listSecteur[id]['nom_chef_secteur'],
                          overflow: TextOverflow.ellipsis,
                        )),
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
                                              ['designation_secteur'],
                                          nomChefSecteur: listSecteur[id]
                                              ['nom_chef_secteur'],
                                        ),
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
                                  getCodeAuth(
                                      context: context,
                                      onCall: () async {
                                        if (code.text.isNotEmpty) {
                                          var res =
                                              await Provider.of<AuthProvider>(
                                            context,
                                            listen: false,
                                          ).codeAuth(
                                            idAmin: users.id.toString(),
                                            code: code.text.toString(),
                                            context: context,
                                          );
                                          if (res) {
                                            // ignore: use_build_context_synchronously
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .getDeleteSecteur(
                                                    secteur: Secteur(
                                                      id: listSecteur[id]['id'],
                                                      descriptionSecteur:
                                                          listSecteur[id][
                                                              'description_secteur'],
                                                      designationSecteur:
                                                          listSecteur[id][
                                                              'designation_secteur'],
                                                      nomChefSecteur: listSecteur[
                                                              id]
                                                          ['nom_chef_secteur'],
                                                    ),
                                                    context: context);

                                            // ignore: use_build_context_synchronously
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .provideListSecteur();
                                          }
                                          code.clear();
                                        } else {
                                          echecTransaction(
                                              "Entrez le code svp!", context);
                                        }
                                      });
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
