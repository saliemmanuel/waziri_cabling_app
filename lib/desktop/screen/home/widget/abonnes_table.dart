import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import 'action_dialogue.dart';
import 'add_abonnes.dart';
import 'detail_abonne.dart';

class AbonnesTable extends StatelessWidget {
  final Users users;
  final dynamic abonnesList;
  const AbonnesTable(
      {super.key, required this.abonnesList, required this.users});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
              CustomText(
                  data: "Liste des abonnées (${abonnesList.length ?? ""})"),
              const SizedBox(width: 70.0),
              Container(
                alignment: Alignment.center,
                height: 35.0,
                width: 250.0,
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
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Search'),
                    )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconlyBold.search, color: Palette.grey),
                    )
                  ],
                ),
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
                        data: "Ajoutez un abonné",
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                      context: context, child: AddBonnes(users: users));
                },
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: CustomText(data: 'N°')),
                  DataColumn(
                      label: Expanded(
                          child: Text('Nom et prénom',
                              overflow: TextOverflow.ellipsis))),
                  DataColumn(label: CustomText(data: 'Téléphone')),
                  DataColumn(
                      label: Expanded(
                    child:
                        CustomText(selectable: false, data: 'Description zone'),
                  )),
                  DataColumn(
                      label: Text('Secteur abonné',
                          overflow: TextOverflow.ellipsis)),
                  DataColumn(
                      label: Expanded(child: CustomText(data: '   Action'))),
                ],
                rows: [
                  for (var index = 0; index < abonnesList!.length; index++)
                    DataRow(
                      color: index % 2 == 0
                          ? MaterialStateProperty.all(
                              Colors.grey.withOpacity(0.1))
                          : MaterialStateProperty.all(Colors.white),
                      cells: [
                        DataCell(CustomText(data: '${index + 1}')),
                        DataCell(
                          Text(
                            "${abonnesList![index]['nom_abonne']}\n${abonnesList![index]['prenom_abonne']}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DataCell(CustomText(
                            selectable: true,
                            data: abonnesList![index]['telephone_abonne']
                                .toString())),
                        DataCell(CustomText(
                          data: abonnesList![index]['description_zone_abonne'],
                          selectable: true,
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                              data: abonnesList![index]['secteur_abonne']
                                  .toString()),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(right: 100.0),
                          child: Row(children: [
                            Expanded(
                              child: MaterialButton(
                                  color: Palette.online,
                                  child: const CustomText(
                                      data: "Détail", color: Colors.white),
                                  onPressed: () {
                                    var abonne = AbonneModels(
                                        id: abonnesList![index]['id']
                                            .toString(),
                                        nomAbonne: abonnesList![index]['nom_abonne']
                                            .toString(),
                                        prenomAbonne: abonnesList![index]
                                                ['prenom_abonne']
                                            .toString(),
                                        cniAbonne: abonnesList![index]['cni_abonne']
                                            .toString(),
                                        telephoneAbonne: abonnesList![index]
                                                ['telephone_abonne']
                                            .toString(),
                                        descriptionZoneAbonne: abonnesList![index]
                                                ['description_zone_abonne']
                                            .toString(),
                                        secteurAbonne: abonnesList![index]
                                                ['secteur_abonne']
                                            .toString(),
                                        idChefSecteur: abonnesList![index]
                                                ['id_chef_secteur']
                                            .toString(),
                                        typeAbonnement: abonnesList![index]['type_abonnement'].toString(),
                                        idTypeAbonnement: abonnesList![index]['id_type_abonnement'].toString());
                                    actionDialogue(
                                        child: DetailAbonne(abonne: abonne),
                                        context: context);
                                  }),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: MaterialButton(
                                  color: Colors.red,
                                  onPressed: () async {
                                    getCodeAuth(
                                        context: context,
                                        onCall: () async {
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
                                            var abonne = AbonneModels(
                                                id: abonnesList![index]['id']
                                                    .toString(),
                                                nomAbonne: abonnesList![index]
                                                    ['nom_abonne'],
                                                prenomAbonne: abonnesList![index]
                                                    ['prenom_abonne'],
                                                cniAbonne: abonnesList![index]
                                                    ['cni_abonne'],
                                                telephoneAbonne: abonnesList![index]
                                                        ['telephone_abonne']
                                                    .toString(),
                                                descriptionZoneAbonne: abonnesList![index]
                                                    ['description_zone_abonne'],
                                                secteurAbonne: abonnesList![index]
                                                    ['secteur_abonne'],
                                                idChefSecteur: abonnesList![index]
                                                        ['id_chef_secteur']
                                                    .toString(),
                                                typeAbonnement: abonnesList![index]
                                                        ['type_abonnement']
                                                    .toString(),
                                                idTypeAbonnement:
                                                    abonnesList![index]['id_type_abonnement'].toString());
                                            // ignore: use_build_context_synchronously
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .getDeleteAbonne(
                                                    abonne: abonne,
                                                    context: context);
                                            // ignore: use_build_context_synchronously
                                            Provider.of<HomeProvider>(context,
                                                    listen: false)
                                                .provideListeAbonnes(
                                                    users: users);
                                          }
                                          code.clear();
                                        });
                                  },
                                  child: const Icon(IconlyBold.delete,
                                      color: Colors.white)),
                            ),
                          ]),
                        )),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ]));
  }
}
