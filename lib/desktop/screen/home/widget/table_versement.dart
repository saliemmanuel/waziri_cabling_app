import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/models/users.dart';
import 'package:waziri_cabling_app/models/versement_models.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../log/provider/auth_provider.dart';
import 'action_dialogue.dart';
import 'add_versement.dart';
import 'detail_versement.dart';

class TableVersement extends StatefulWidget {
  final dynamic listVersements;
  final Users users;
  const TableVersement({super.key, this.listVersements, required this.users});

  @override
  State<TableVersement> createState() => _TableVersementState();
}

class _TableVersementState extends State<TableVersement> {
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
              const CustomText(
                  data: "Liste versement des secteurs",
                  fontWeight: FontWeight.bold),
              const SizedBox(width: 50.0),
              Row(
                children: [
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
                              border: InputBorder.none,
                              hintText: 'Search (Nom secteur)'),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .provideVersements();
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListVersement(value);
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
                  height: 35.0,
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palette.teal),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Palette.teal),
                      CustomText(
                          data: "Ajoutez un versement",
                          color: Palette.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: const AddVersement(),
                  );
                },
              ),
            ],
          ),
          const Divider(),
          Expanded(
              child: SingleChildScrollView(
            child: DataTable(columns: const [
              DataColumn(label: CustomText(data: 'N°')),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                    data: 'Nom secteur', overflow: TextOverflow.clip),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Nom chef secteur',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Somme verser',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Date versement',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(label: CustomText(data: '   Action')),
            ], rows: [
              for (var i = 0; i < widget.listVersements.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: widget.listVersements[i]['nom_secteur'])),
                      DataCell(CustomText(
                          data: widget.listVersements[i]['nom_chef_secteur'])),
                      DataCell(CustomText(
                          data: widget.listVersements[i]['somme_verser'])),
                      DataCell(CustomText(
                          data: widget.listVersements[i]['date_versement'])),
                      DataCell(Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                                color: Palette.online,
                                child: const CustomText(
                                    data: "Détail", color: Palette.white),
                                onPressed: () {
                                  actionDialogue(
                                      context: context,
                                      child: DetailVersement(
                                          versementModels: VersementModels(
                                              id: widget.listVersements[i]['id']
                                                  .toString(),
                                              nomSecteur: widget.listVersements[i]
                                                  ['nom_secteur'],
                                              nomChefSecteur: widget.listVersements[i]
                                                  ['nom_chef_secteur'],
                                              sommeVerser: widget.listVersements[i]
                                                      ['somme_verser']
                                                  .toString(),
                                              dateVersement: widget.listVersements[i]
                                                      ['date_versement']
                                                  .toString(),
                                              idSecteur: widget.listVersements[i]
                                                      ['id_secteur']
                                                  .toString(),
                                              idChefSecteur:
                                                  widget.listVersements[i]['id_chef_secteur'].toString())));
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: MaterialButton(
                            color: Palette.red,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                            onPressed: () async {
                              getCodeAuth(
                                  context: context,
                                  onCall: () async {
                                    if (code.text.isNotEmpty) {
                                      var res = await Provider.of<AuthProvider>(
                                        context,
                                        listen: false,
                                      ).codeAuth(
                                        idAmin: widget.users.id.toString(),
                                        code: code.text.toString(),
                                        context: context,
                                      );
                                      if (res) {
                                        // ignore: use_build_context_synchronously
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .getDeleteVersement(
                                                context: context,
                                                versement: VersementModels(
                                                  id: widget.listVersements[i]
                                                          ['id']
                                                      .toString(),
                                                  nomSecteur:
                                                      widget.listVersements[i]
                                                          ['nom_secteur'],
                                                  nomChefSecteur:
                                                      widget.listVersements[i]
                                                          ['nom_chef_secteur'],
                                                  sommeVerser: widget
                                                      .listVersements[i]
                                                          ['somme_verser']
                                                      .toString(),
                                                  dateVersement:
                                                      widget.listVersements[i]
                                                          ['date_versement'],
                                                  idSecteur: widget
                                                      .listVersements[i]
                                                          ['id_secteur']
                                                      .toString(),
                                                  idChefSecteur: widget
                                                      .listVersements[i]
                                                          ['id_chef_secteur']
                                                      .toString(),
                                                ));
                                      }
                                      code.clear();
                                    } else {
                                      echecTransaction(
                                          "Entrez le code svp!", context);
                                    }
                                  });
                            },
                          )),
                        ],
                      )),
                    ]),
            ]),
          ))
        ],
      ),
    );
  }
}
