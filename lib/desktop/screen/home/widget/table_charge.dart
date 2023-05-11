import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/detail_charges.dart';
import 'package:waziri_cabling_app/models/charge_models.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../models/pannes_models.dart';
import '../../../../models/users.dart';
import '../../../../models/versement_models.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'action_dialogue.dart';
import 'add_charge.dart';
import 'add_versement.dart';
import 'detail_pannes.dart';

class TableCharge extends StatefulWidget {
  final dynamic listCharge;
  final Users users;
  const TableCharge({super.key, this.listCharge, required this.users});

  @override
  State<TableCharge> createState() => _TableChargeState();
}

class _TableChargeState extends State<TableCharge> {
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
                  data: "Liste charge (${widget.listCharge.length ?? ""})",
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
                                  .providePannes();
                            } else {
                              // Provider.of<HomeProvider>(context, listen: false)
                              //     .searchInlistCharge(value);
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
                          data: "Ajoutez une charge",
                          color: Palette.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: const AddCharge(),
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
                    data: 'Designation charge', overflow: TextOverflow.clip),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Description charge',
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
                  data: 'Date charge',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(label: CustomText(data: '   Action')),
            ], rows: [
              for (var i = 0; i < widget.listCharge.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: widget.listCharge[i]['designation_charge'])),
                      DataCell(CustomText(
                          data: widget.listCharge[i]['description_charge'])),
                      DataCell(CustomText(
                          data: widget.listCharge[i]['somme_verser'])),
                      DataCell(CustomText(
                          data: widget.listCharge[i]['date_charge'])),
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
                                      child: DetailCharges(
                                          chargeModels: ChargeModels(
                                              id: widget.listCharge[i]['id']
                                                  .toString(),
                                              designationCharge:
                                                  widget.listCharge[i]
                                                      ['designation_charge'],
                                              descriptionCharge:
                                                  widget.listCharge[i]
                                                      ['description_charge'],
                                              dateCharge: widget.listCharge[i]
                                                  ['date_charge'],
                                              sommeCharge: widget.listCharge[i]
                                                  ['somme_verser'])));
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
                                            .getDeleteCharge(
                                                context: context,
                                                charge: ChargeModels(
                                                  id: widget.listCharge[i]['id']
                                                      .toString(),
                                                  designationCharge: widget
                                                          .listCharge[i]
                                                      ['designation_charge'],
                                                  descriptionCharge: widget
                                                          .listCharge[i]
                                                      ['description_charge'],
                                                  sommeCharge: widget
                                                      .listCharge[i]
                                                          ['somme_verser']
                                                      .toString(),
                                                  dateCharge: widget
                                                      .listCharge[i]
                                                          ['date_charge']
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
