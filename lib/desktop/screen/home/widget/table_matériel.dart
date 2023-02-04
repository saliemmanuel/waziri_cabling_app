import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/api/host.dart';
import 'package:waziri_cabling_app/models/materiel_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'action_dialogue.dart';
import 'add_materiel.dart';
import 'detail_materiel.dart';

class TableMateriel extends StatefulWidget {
  final listMateriel;
  final Users users;
  const TableMateriel({super.key, this.listMateriel, required this.users});

  @override
  State<TableMateriel> createState() => TableMaterielState();
}

class TableMaterielState extends State<TableMateriel> {
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
                  data: "Liste matériels (${widget.listMateriel.length ?? ""})",
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
                              border: InputBorder.none, hintText: 'Search'),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .provideMateriels();
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListMateriel(value);
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
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.teal),
                      CustomText(
                          data: "Ajoutez un matériel",
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: const AddMateriel(),
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
                  data: 'Prix',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Date achat',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Du',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(label: CustomText(data: '   Action')),
            ], rows: [
              for (var i = 0; i < widget.listMateriel.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: widget.listMateriel[i]
                              ['designation_materiel'])),
                      DataCell(CustomText(
                          data: widget.listMateriel[i]['prix_materiel'])),
                      DataCell(CustomText(
                          data: widget.listMateriel[i]['date_achat_materiel'])),
                      DataCell(CustomText(
                          data: widget.listMateriel[i]['created_at'])),
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
                                      child: DetailMateriel(
                                        materiel: MaterielModels(
                                            id: widget.listMateriel[i]['id'],
                                            designationMateriel:
                                                widget.listMateriel[i]
                                                    ['designation_materiel'],
                                            dateAchatMateriel:
                                                widget.listMateriel[i]
                                                    ['date_achat_materiel'],
                                            factureMateriel: Host.host +
                                                widget.listMateriel[i]
                                                    ['facture_materiel'],
                                            imageMateriel: Host.host +
                                                widget.listMateriel[i]
                                                    ['image_materiel'],
                                            prixMateriel: widget.listMateriel[i]
                                                ['prix_materiel'],
                                            createAt: widget.listMateriel[i]
                                                ['created_at']),
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
                                    var res = await Provider.of<AuthProvider>(
                                      context,
                                      listen: false,
                                    ).codeAuth(
                                      idAmin: widget.users.id.toString(),
                                      code: code.text.toString(),
                                      context: context,
                                    );
                                    if (res) {
                                      print(res);
                                      // ignore: use_build_context_synchronously
                                      Provider.of<HomeProvider>(context, listen: false).getDeleteMateriel(
                                          context: context,
                                          materiel: MaterielModels(
                                              id: widget.listMateriel[i]['id'],
                                              designationMateriel:
                                                  widget.listMateriel[i]
                                                      ['designation_materiel'],
                                              dateAchatMateriel:
                                                  widget.listMateriel[i]
                                                      ['date_achat_materiel'],
                                              factureMateriel: Host.host +
                                                  widget.listMateriel[i]
                                                      ['facture_materiel'],
                                              imageMateriel: Host.host +
                                                  widget.listMateriel[i]
                                                      ['image_materiel'],
                                              prixMateriel:
                                                  widget.listMateriel[i]
                                                      ['prix_materiel'],
                                              createAt: widget.listMateriel[i]
                                                  ['created_at']));

                                      // ignore: use_build_context_synchronously
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .provideMateriels();
                                    }
                                    code.clear();
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
