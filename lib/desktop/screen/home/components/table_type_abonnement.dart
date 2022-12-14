import 'package:flutter/material.dart';
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
import '../widget/add_type_abonnemet.dart';

class TableTypeAbonnement extends StatelessWidget {
  final dynamic listTypeAbonnement;
  final Users users;
  const TableTypeAbonnement(
      {super.key, required this.listTypeAbonnement, required this.users});

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
                      "Liste types abonnements (${listTypeAbonnement.length ?? ""})",
                  fontWeight: FontWeight.bold),
              const SizedBox(width: 50.0),
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
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
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
                          data: "Ajoutez un type d'abonnement",
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                    context: context,
                    child: AddTypeAbonnement(users: users),
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
              for (var i = 0; i < listTypeAbonnement.length; i++)
                DataRow(
                    color: i % 2 == 0
                        ? MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1))
                        : MaterialStateProperty.all(Colors.white),
                    cells: [
                      DataCell(CustomText(data: '${i + 1}')),
                      DataCell(CustomText(
                          data: listTypeAbonnement[i]
                              ['designation_type_abonnement'])),
                      DataCell(
                          CustomText(data: listTypeAbonnement[i]['montant'])),
                      DataCell(CustomText(
                          data: listTypeAbonnement[i]['nombre_chaine'])),
                      DataCell(Row(
                        children: [
                          Expanded(
                              child: MaterialButton(
                                  color: Colors.teal,
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () {})),
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
                                      idAmin: users.id.toString(),
                                      code: code.text.toString(),
                                      context: context,
                                    );
                                    if (res) {
                                      print(res);
                                      // ignore: use_build_context_synchronously
                                      Provider.of<HomeProvider>(context, listen: false)
                                          .getDeleteTypeAbonnement(
                                              type: TypeAbonnement(
                                                  id: listTypeAbonnement[i]
                                                      ['id'],
                                                  designationTypeAbonnement:
                                                      listTypeAbonnement[i][
                                                              'designation_type_abonnement']
                                                          .toString(),
                                                  montant: listTypeAbonnement[i]
                                                          ['montant']
                                                      .toString(),
                                                  nombreChaine:
                                                      listTypeAbonnement[i]
                                                              ['nombre_chaine']
                                                          .toString(),
                                                  idInitiateur:
                                                      listTypeAbonnement[i]
                                                              ['id_initiateur']
                                                          .toString()),
                                              context: context);
                                      print("delete");
                                      print(listTypeAbonnement[i]);
                                      // ignore: use_build_context_synchronously
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .provideListeTypeAbonnement();
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
