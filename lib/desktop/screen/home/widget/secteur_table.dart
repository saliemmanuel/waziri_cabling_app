import 'package:fluent_ui/fluent_ui.dart';
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
import 'detail_seteur.dart';

class SecteurTable extends StatefulWidget {
  final listSecteur;
  final Users users;
  const SecteurTable(
      {super.key, required this.listSecteur, required this.users});

  @override
  State<SecteurTable> createState() => _SecteurTableState();
}

class _SecteurTableState extends State<SecteurTable> {
  var listTypeSearch = ['Nom chef-secteur', 'Désignation'];
  var selectedSearch = '';
  var controller = TextEditingController();
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
                  data:
                      "Liste des secteurs (${widget.listSecteur.length ?? ""})"),
              const SizedBox(width: 70.0),
              Row(
                children: [
                  ComboBox<String>(
                    style: const TextStyle(color: Palette.teal),
                    value: selectedSearch,
                    items: listTypeSearch.map<ComboBoxItem<String>>((e) {
                      return ComboBoxItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedSearch = value!);
                      Provider.of<HomeProvider>(context, listen: false)
                          .provideListSecteur();
                    },
                    placeholder: const Text("Recherche par"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 35.0,
                    width: 200.0,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.teal),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .provideListSecteur();
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListSecteur(
                                      value,
                                      selectedSearch == 'Désignation'
                                          ? "designation_secteur"
                                          : "nom_chef_secteur");
                            }
                          },
                        )),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(IconlyBold.search, color: Palette.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palette.teal),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Palette.teal),
                      CustomText(
                        data: "Ajoutez un secteur",
                        color: Palette.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                      context: context, child: AddSecteur(users: widget.users));
                },
              ),
            ],
          ),
          Container(height: 1, color: Palette.grey, width: double.infinity),
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
                for (var id = 0; id < widget.listSecteur.length; id++)
                  DataRow(
                      color: id % 2 == 0
                          ? MaterialStateProperty.all(
                              Palette.grey.withOpacity(0.1))
                          : MaterialStateProperty.all(Palette.white),
                      cells: [
                        DataCell(CustomText(data: "${id + 1}")),
                        DataCell(CustomText(
                            selectable: true,
                            data: widget.listSecteur[id]
                                ['designation_secteur'])),
                        DataCell(CustomText(
                            data: widget.listSecteur[id]['description_secteur'],
                            overflow: TextOverflow.clip)),
                        DataCell(CustomText(
                          data: widget.listSecteur[id]['nom_chef_secteur'],
                          overflow: TextOverflow.ellipsis,
                        )),
                        DataCell(Row(children: [
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Palette.online,
                                child: const CustomText(
                                    data: "Détail", color: Palette.white),
                                onPressed: () async {
                                  actionDialogue(
                                      child: DetailSecteur(
                                        secteur: Secteur(
                                            id: widget.listSecteur[id]['id']
                                                .toString(),
                                            descriptionSecteur:
                                                widget.listSecteur[id]
                                                    ['description_secteur'],
                                            designationSecteur:
                                                widget.listSecteur[id]
                                                    ['designation_secteur'],
                                            nomChefSecteur:
                                                widget.listSecteur[id]
                                                    ['nom_chef_secteur'],
                                            idChefSecteur: widget
                                                .listSecteur[id]
                                                    ['id_chef_secteur']
                                                .toString()),
                                      ),
                                      context: context);
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Palette.red,
                                child: const Icon(IconlyBold.delete,
                                    color: Palette.white),
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
                                            idAmin: widget.users.id.toString(),
                                            code: code.text.toString(),
                                            context: context,
                                          );
                                          if (res) {
                                            // ignore: use_build_context_synchronously
                                            Provider.of<HomeProvider>(context, listen: false).getDeleteSecteur(
                                                secteur: Secteur(
                                                    id: widget.listSecteur[id]
                                                            ['id']
                                                        .toString(),
                                                    descriptionSecteur: widget
                                                            .listSecteur[id]
                                                        ['description_secteur'],
                                                    designationSecteur: widget
                                                            .listSecteur[id]
                                                        ['designation_secteur'],
                                                    nomChefSecteur: widget
                                                        .listSecteur[id]
                                                            ['id_chef_secteur']
                                                        .toString(),
                                                    idChefSecteur: widget
                                                            .listSecteur[id]
                                                        ['nom_chef_secteur']),
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
