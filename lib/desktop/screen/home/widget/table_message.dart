// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/message_moi_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'action_dialogue.dart';
import 'add_message_mois.dart';
import 'detail_message_mois.dart';

class TableMessage extends StatefulWidget {
  final List listMessage;
  final Users users;
  const TableMessage(
      {super.key, required this.listMessage, required this.users});

  @override
  State<TableMessage> createState() => _TableMessageState();
}

class _TableMessageState extends State<TableMessage> {
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
                  data: "Liste message (${widget.listMessage.length})",
                  fontWeight: FontWeight.bold),
              const SizedBox(width: 50.0),
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
                          data: "Ajoutez un message",
                          color: Palette.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: const AddMessageMois(),
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
                    data: 'Désignation message', overflow: TextOverflow.clip),
              )),
              DataColumn(
                  label: Expanded(
                child: CustomText(
                  data: 'Corps message',
                  overflow: TextOverflow.clip,
                ),
              )),
              DataColumn(label: CustomText(data: '   Action')),
            ], rows: [
              for (var i = 0; i < widget.listMessage.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: widget.listMessage[i]['designation_message'])),
                      DataCell(CustomText(
                          data: widget.listMessage[i]['corps_message'])),
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
                                    child: DetailMessageMois(
                                      messageMoisModel: MessageMoisModel(
                                        id: widget.listMessage[i]['id']
                                            .toString(),
                                        designationMessageMois: widget
                                            .listMessage[i]
                                                ['designation_message']
                                            .toString(),
                                        corpsMessageMois: widget.listMessage[i]
                                                ['corps_message']
                                            .toString(),
                                      ),
                                    ),
                                  );
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
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .getDeleteMessageMois(
                                                context: context,
                                                message: MessageMoisModel(
                                                  id: widget.listMessage[i]
                                                          ['id']
                                                      .toString(),
                                                  designationMessageMois: widget
                                                          .listMessage[i]
                                                      ['designation_message'],
                                                  corpsMessageMois:
                                                      widget.listMessage[i]
                                                          ['corps_message'],
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
