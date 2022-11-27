import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/global_widget/widget.dart';

import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      {
        "id": 1,
        "nom_utilisateur": "s",
        "prenom_utilisateur": "EMMANUEL",
        "email_utilisateur": "ds",
        "telephone_utilisateur": 59,
        "role_utilisateur": "admin",
        "zone_utilisateur": "pitoaré secteur saphir",
        "id_utilisateur_initiateur": "0",
        "created_at": "2022-11-25T21:40:32.000000Z",
        "updated_at": "2022-11-25T21:40:32.000000Z"
      },
      {
        "id": 1,
        "nom_utilisateur": "s",
        "prenom_utilisateur": "EMMANUEL",
        "email_utilisateur": "ds",
        "telephone_utilisateur": 59,
        "role_utilisateur": "admin",
        "zone_utilisateur": "pitoaré secteur saphir",
        "id_utilisateur_initiateur": "0",
        "created_at": "2022-11-25T21:40:32.000000Z",
        "updated_at": "2022-11-25T21:40:32.000000Z"
      },
      {
        "id": 1,
        "nom_utilisateur": "s",
        "prenom_utilisateur": "EMMANUEL",
        "email_utilisateur": "ds",
        "telephone_utilisateur": 59,
        "role_utilisateur": "admin",
        "zone_utilisateur": "pitoaré secteur saphir",
        "id_utilisateur_initiateur": "0",
        "created_at": "2022-11-25T21:40:32.000000Z",
        "updated_at": "2022-11-25T21:40:32.000000Z"
      },
    ];
    bool selectedItem = false;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(data: "List Utilisateur"),
              Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 230.0,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                )),
              ),
              Container(
                alignment: Alignment.center,
                height: 40.0,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.teal),
                    CustomText(
                        data: "Ajoutez un utilisateur",
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                showBottomBorder: true,
                columns: const [
                  DataColumn2(
                      label: CustomText(data: 'N°'), size: ColumnSize.S),
                  DataColumn2(
                      label: CustomText(data: 'Nom et prénom'),
                      size: ColumnSize.L),
                  DataColumn2(
                      label: CustomText(
                        data: 'E-mail',
                        overflow: TextOverflow.ellipsis,
                      ),
                      size: ColumnSize.L),
                  DataColumn2(
                      label: CustomText(data: 'Téléphone'), size: ColumnSize.M),
                  DataColumn2(
                      label: CustomText(
                        data: 'Rôle',
                        overflow: TextOverflow.ellipsis,
                      ),
                      size: ColumnSize.S),
                  DataColumn2(
                      label: CustomText(
                        data: 'Zone',
                        overflow: TextOverflow.ellipsis,
                      ),
                      size: ColumnSize.S),
                  DataColumn2(
                      label: CustomText(data: 'Action'), size: ColumnSize.S),
                ], // DataCell(CustomText(data: e['id'].toString())),
                rows: list
                    .map((e) => DataRow(
                          cells: e.values
                              .map((value) => DataCell(CustomText(
                                    data: value.toString(),
                                  )))
                              .toList(),
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
