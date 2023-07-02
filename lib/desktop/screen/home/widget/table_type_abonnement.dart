// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/action_dialogue.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'add_type_abonnemet.dart';
import 'detail_type_abonnement.dart';

class TableTypeAbonnement extends StatefulWidget {
  final dynamic listTypeAbonnement;
  final Users users;
  const TableTypeAbonnement(
      {super.key, required this.listTypeAbonnement, required this.users});

  @override
  State<TableTypeAbonnement> createState() => _TableTypeAbonnementState();
}

class _TableTypeAbonnementState extends State<TableTypeAbonnement> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.listTypeAbonnement);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
              CustomText(
                  data:
                      "Liste types abonnements ",
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
                                  .provideListeTypeAbonnement();
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListTypeAbonnement(
                                      value, "designation_type_abonnement");
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.teal),
                      CustomText(
                          data: "Ajoutez un type d'abonnement",
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: AddTypeAbonnement(users: widget.users),
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
                    data: 'Désignation type abonnement',
                    overflow: TextOverflow.clip),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Montant type abonnement (Fcfa)',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Nombre de chaine',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(label: CustomText(data: '   Action')),
            ], rows: [
              for (var i = 0; i < widget.listTypeAbonnement.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: widget.listTypeAbonnement[i]
                              ['designation_type_abonnement'])),
                      DataCell(CustomText(
                          data: widget.listTypeAbonnement[i]['montant'])),
                      DataCell(CustomText(
                          data: widget.listTypeAbonnement[i]['nombre_chaine'])),
                      DataCell(Row(
                        children: [
                          Expanded(
                              child: MaterialButton(
                                  color: Colors.teal,
                                  child: const CustomText(
                                      data: "Détail", color: Colors.white),
                                  onPressed: () {
                                    actionDialogue(
                                        context: context,
                                        child: DetailTypeAbonnement(
                                          users: widget.users,
                                          type: TypeAbonnement(
                                              id: widget.listTypeAbonnement[i]['id']
                                                  .toString(),
                                              designationTypeAbonnement: widget
                                                  .listTypeAbonnement[i][
                                                      'designation_type_abonnement']
                                                  .toString(),
                                              montant: widget.listTypeAbonnement[i]
                                                      ['montant']
                                                  .toString(),
                                              nombreChaine: widget.listTypeAbonnement[i]
                                                      ['nombre_chaine']
                                                  .toString(),
                                              idInitiateur: widget.listTypeAbonnement[i]
                                                      ['id_initiateur']
                                                  .toString()),
                                        ));
                                  })),
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
                                        Provider.of<HomeProvider>(context, listen: false)
                                            .getDeleteTypeAbonnement(
                                                type: TypeAbonnement(
                                                    id: widget.listTypeAbonnement[i]
                                                        ['id'],
                                                    designationTypeAbonnement:
                                                        widget.listTypeAbonnement[i]['designation_type_abonnement']
                                                            .toString(),
                                                    montant: widget
                                                        .listTypeAbonnement[i]
                                                            ['montant']
                                                        .toString(),
                                                    nombreChaine: widget.listTypeAbonnement[i]
                                                            ['nombre_chaine']
                                                        .toString(),
                                                    idInitiateur: widget
                                                        .listTypeAbonnement[i]
                                                            ['id_initiateur']
                                                        .toString()),
                                                context: context);
                                        print(widget.listTypeAbonnement[i]);
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .provideListeTypeAbonnement();
                                      }
                                      code.clear();
                                    } else {}
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
