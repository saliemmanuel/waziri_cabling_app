import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/add_pannes.dart';
import 'package:waziri_cabling_app/models/pannes_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'action_dialogue.dart';
import 'detail_pannes.dart';

class TablePannes extends StatefulWidget {
  final listPannes;
  final Users users;
  const TablePannes({super.key, this.listPannes, required this.users});

  @override
  State<TablePannes> createState() => _TablePannesState();
}

class _TablePannesState extends State<TablePannes> {
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
                  data: "Liste matériels ",
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
                              hintText: 'Search(désignation)'),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .providePannes();
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListPannes(value);
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Palette.teal),
                      CustomText(
                          data: "Ajoutez une pannes",
                          color: Palette.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: AddPannes(users: widget.users),
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
                    data: 'Désignation', overflow: TextOverflow.clip),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Description',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Detected date',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'secteur',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(label: CustomText(data: '   Action')),
            ], rows: [
              for (var i = 0; i < widget.listPannes.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: widget.listPannes[i]['designation'])),
                      DataCell(CustomText(
                          data: widget.listPannes[i]['description'])),
                      DataCell(CustomText(
                          data: widget.listPannes[i]['detected_date'])),
                      DataCell(
                          CustomText(data: widget.listPannes[i]['secteur'])),
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
                                      child: DetailPannes(
                                        users: widget.users,
                                        pannes: PannesModels(
                                          id: widget.listPannes[i]['id']
                                              .toString(),
                                          designation: widget.listPannes[i]
                                              ['designation'],
                                          description: widget.listPannes[i]
                                              ['description'],
                                          detectedDate: widget.listPannes[i]
                                                  ['detected_date']
                                              .toString(),
                                          secteur: widget.listPannes[i]
                                              ['secteur'],
                                        ),
                                      ));
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
                                            .getDeletePannes(
                                                context: context,
                                                pannes: PannesModels(
                                                    id: widget.listPannes[i]
                                                            ['id']
                                                        .toString(),
                                                    designation:
                                                        widget.listPannes[i]
                                                            ['designation'],
                                                    description:
                                                        widget.listPannes[i]
                                                            ['description'],
                                                    detectedDate: widget
                                                        .listPannes[i]
                                                            ['detected_date']
                                                        .toString(),
                                                    secteur:
                                                        widget.listPannes[i]
                                                            ['secteur']));
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
