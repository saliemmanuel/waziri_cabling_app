import 'package:fluent_ui/fluent_ui.dart';
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

class AbonnesTable extends StatefulWidget {
  final Users users;
  final dynamic abonnesList;
  const AbonnesTable(
      {super.key, required this.abonnesList, required this.users});

  @override
  State<AbonnesTable> createState() => _AbonnesTableState();
}

class _AbonnesTableState extends State<AbonnesTable> {
  var listTypeSearch = ['Nom', 'Téléphone'];
  var selectedSearch = '';
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
             const CustomText(
                  data:
                      "Liste des abonnées"),
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
                          .provideListeAbonnes(users: widget.users);
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
                                  .provideListeAbonnes(users: widget.users);
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListAbonne(
                                      value,
                                      selectedSearch == 'Téléphone'
                                          ? "telephone_abonne"
                                          : "nom_abonne");
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
                        data: "Ajoutez un abonné",
                        color: Palette.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                      context: context, child: AddBonnes(users: widget.users));
                },
              ),
            ],
          ),
          Container(height: 1, color: Palette.grey, width: double.infinity),
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
                  for (var index = 0;
                      index < widget.abonnesList!.length;
                      index++)
                    DataRow(
                      color: index % 2 == 0
                          ? MaterialStateProperty.all(
                              Palette.grey.withOpacity(0.1))
                          : MaterialStateProperty.all(Palette.white),
                      cells: [
                        DataCell(CustomText(data: '${index + 1}')),
                        DataCell(
                          Text(
                            "${widget.abonnesList![index]['nom_abonne']}\n${widget.abonnesList![index]['prenom_abonne']}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DataCell(CustomText(
                            selectable: true,
                            data: widget.abonnesList![index]['telephone_abonne']
                                .toString())),
                        DataCell(CustomText(
                          data: widget.abonnesList![index]
                              ['description_zone_abonne'],
                          selectable: true,
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                              data: widget.abonnesList![index]['secteur_abonne']
                                  .toString()),
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(right: 100.0),
                          child: Row(children: [
                            Expanded(
                              child: MaterialButton(
                                  color: Palette.online,
                                  child: const CustomText(
                                      data: "Détail", color: Palette.white),
                                  onPressed: () {
                                    var abonne = AbonneModels(
                                        id: widget.abonnesList![index]['id']
                                            .toString(),
                                        nomAbonne: widget.abonnesList![index]
                                                ['nom_abonne']
                                            .toString(),
                                        prenomAbonne: widget.abonnesList![index]
                                                ['prenom_abonne']
                                            .toString(),
                                        cniAbonne: widget.abonnesList![index]
                                                ['cni_abonne']
                                            .toString(),
                                        telephoneAbonne: widget
                                            .abonnesList![index]
                                                ['telephone_abonne']
                                            .toString(),
                                        descriptionZoneAbonne: widget
                                            .abonnesList![index]
                                                ['description_zone_abonne']
                                            .toString(),
                                        secteurAbonne: widget.abonnesList![index]['secteur_abonne'].toString(),
                                        idChefSecteur: widget.abonnesList![index]['id_chef_secteur'].toString(),
                                        typeAbonnement: widget.abonnesList![index]['type_abonnement'].toString(),
                                        idTypeAbonnement: widget.abonnesList![index]['id_type_abonnement'].toString());
                                    actionDialogue(
                                        child: DetailAbonne(
                                            abonne: abonne,
                                            users: widget.users),
                                        context: context);
                                  }),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: MaterialButton(
                                  color: Palette.red,
                                  onPressed: () async {
                                    getCodeAuth(
                                        context: context,
                                        onCall: () async {
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
                                            var abonne = AbonneModels(
                                                id: widget.abonnesList![index]['id']
                                                    .toString(),
                                                nomAbonne: widget.abonnesList![index]
                                                    ['nom_abonne'],
                                                prenomAbonne: widget.abonnesList![index]
                                                    ['prenom_abonne'],
                                                cniAbonne: widget.abonnesList![index]
                                                    ['cni_abonne'],
                                                telephoneAbonne: widget
                                                    .abonnesList![index]
                                                        ['telephone_abonne']
                                                    .toString(),
                                                descriptionZoneAbonne: widget
                                                        .abonnesList![index]
                                                    ['description_zone_abonne'],
                                                secteurAbonne:
                                                    widget.abonnesList![index]
                                                        ['secteur_abonne'],
                                                idChefSecteur: widget.abonnesList![index]['id_chef_secteur'].toString(),
                                                typeAbonnement: widget.abonnesList![index]['type_abonnement'].toString(),
                                                idTypeAbonnement: widget.abonnesList![index]['id_type_abonnement'].toString());
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
                                                    users: widget.users);
                                          }
                                          code.clear();
                                        });
                                  },
                                  child: const Icon(IconlyBold.delete,
                                      color: Palette.white)),
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
