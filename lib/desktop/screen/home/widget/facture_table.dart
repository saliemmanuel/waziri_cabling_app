// ignore_for_file: use_build_context_synchronously

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/detail_facture.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/generate_pdf/facture_pdf_api.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/payement_facture.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../models/users.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'action_dialogue.dart';

class FactureTable extends StatefulWidget {
  final dynamic listFacture;
  final Users users;

  const FactureTable({super.key, this.listFacture, required this.users});

  @override
  State<FactureTable> createState() => _FactureTableState();
}

class _FactureTableState extends State<FactureTable> {
  var listTypeStatut = [
    'impayer',
    'Payer en partie',
    'Totalite',
    'Toute les factures'
  ];
  var listTypeSearch = ['Téléphone', 'N° Facture'];
  var selectedStatut = '';
  var selectedSearch = '';
  var controller = TextEditingController();
  var factureApi = FacturePdfApi();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
              const CustomText(data: "Liste des factures"),
              const SizedBox(width: 10.0),
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
                          .provideListeFacture(
                              users: widget.users,
                              selectedStatut: selectedStatut);
                    },
                    placeholder: const Text("Recherche par"),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    alignment: Alignment.center,
                    height: 35.0,
                    width: 150.0,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.teal),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .provideListeFacture(
                                      users: widget.users,
                                      selectedStatut: selectedStatut);
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInLIstFacture(
                                      value,
                                      selectedSearch == 'Téléphone'
                                          ? "telephone_abonne"
                                          : "numero_facture");
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
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
              const SizedBox(width: 4.0),
              if (widget.users.roleUtilisateur != "chef-secteur")
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 35.0,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.teal),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const CustomText(
                      data: "Etablir factures",
                      color: Palette.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    getCodeAuth(
                        context: context,
                        onCall: () async {
                          if (code.text.isNotEmpty) {
                            var res = await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .codeAuth(
                                    idAmin: widget.users.id.toString(),
                                    code: code.text.toString(),
                                    context: context);
                            if (res) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .generateFacture(
                                      users: widget.users, context: context);
                              Provider.of<HomeProvider>(context, listen: false)
                                  .provideListeFacture(
                                      users: widget.users,
                                      selectedStatut: 'Toute les factures');
                              code.clear();
                            }
                          } else {
                            echecTransaction("Entrez le code svp!", context);
                          }
                        });
                  },
                ),
              const SizedBox(width: 8.0),
              ComboBox<String>(
                style: const TextStyle(color: Palette.teal),
                value: selectedStatut,
                items: listTypeStatut.map<ComboBoxItem<String>>((e) {
                  return ComboBoxItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedStatut = value!);
                  Provider.of<HomeProvider>(context, listen: false)
                      .provideListeFacture(
                          users: widget.users, selectedStatut: selectedStatut);
                },
                placeholder: const Text('Type facture'),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                child: Container(
                    alignment: Alignment.center,
                    height: 35.0,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.teal),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const Icon(
                      FluentIcons.print,
                      color: Palette.teal,
                    )),
                onTap: () {
                  getCodeAuth(
                      context: context,
                      onCall: () async {
                        if (code.text.isNotEmpty) {
                          var res = await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .codeAuth(
                                  idAmin: widget.users.id.toString(),
                                  code: code.text.toString(),
                                  context: context);
                          if (res) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .provideListeFacture(
                                    users: widget.users,
                                    selectedStatut: 'impayer');
                            await factureApi.generateFacture(
                                await Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .listTrie,
                                context);
                            code.clear();
                          }
                        } else {
                          echecTransaction("Entrez le code svp!", context);
                        }
                      });
                },
              ),
            ],
          ),
          Container(height: 1, color: Palette.grey, width: double.infinity),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: CustomText(data: "N°")),
                  DataColumn(label: CustomText(data: "Abonnée")),
                  DataColumn(
                    label: CustomText(
                      data: "Montant verser",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      data: "Reste",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      data: "Statut",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      data: "Impayes",
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      data: "Date",
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      data: "Action",
                    ),
                  ),
                ],
                rows: [
                  for (var id = 0; id < widget.listFacture!.length; id++)
                    DataRow(
                        color: id % 2 == 0
                            ? MaterialStateProperty.all(
                                int.parse(widget.listFacture[id]['impayes']) +
                                            int.parse(widget.listFacture[id]
                                                ['mensualite_facture']) >
                                        5500
                                    ? Palette.red.withOpacity(0.5)
                                    : Palette.grey.withOpacity(0.1))
                            : MaterialStateProperty.all(
                                int.parse(widget.listFacture[id]['impayes']) +
                                            int.parse(widget.listFacture[id]
                                                ['mensualite_facture']) >
                                        5500
                                    ? Palette.red.withOpacity(0.5)
                                    : Palette.white),
                        cells: [
                          DataCell(CustomText(data: "${id + 1}")),
                          DataCell(
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: CustomText(
                                data:
                                    '${widget.listFacture[id]['nom_abonne']}\n${widget.listFacture[id]['prenom_abonne']}',
                              ),
                            ),
                          ),
                          DataCell(
                            CustomText(
                              data:
                                  "${widget.listFacture[id]['montant_verser']}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            CustomText(
                              data:
                                  "${widget.listFacture[id]['reste_facture']}",
                            ),
                          ),
                          DataCell(
                            CustomText(
                              data:
                                  "${widget.listFacture[id]['statut_facture']}",
                            ),
                          ),
                          DataCell(
                            CustomText(
                              data: "${widget.listFacture[id]['impayes']}",
                            ),
                          ),
                          DataCell(CustomText(
                              data: widget.listFacture[id]['create_fm'])),
                          DataCell(Row(children: [
                            Expanded(
                              child: MaterialButton(
                                  color: Palette.online,
                                  child: const CustomText(
                                      data: "Détail", color: Palette.white),
                                  onPressed: () {
                                    actionDialogue(
                                        context: context,
                                        child: DetailFacture(
                                          users: widget.users,
                                          facture: FactureModels(
                                            idFacture: widget.listFacture[id]
                                                    ['id_facture']
                                                .toString(),
                                            numeroFacture: widget
                                                .listFacture[id]
                                                    ['numero_facture']
                                                .toString(),
                                            mensualiteFacture: widget
                                                .listFacture[id]
                                                    ['mensualite_facture']
                                                .toString(),
                                            montantVerser: widget
                                                .listFacture[id]
                                                    ['montant_verser']
                                                .toString(),
                                            resteFacture: widget.listFacture[id]
                                                    ['reste_facture']
                                                .toString(),
                                            statutFacture: widget
                                                .listFacture[id]
                                                    ['statut_facture']
                                                .toString(),
                                            impayes: widget.listFacture[id]
                                                    ['impayes']
                                                .toString(),
                                            idAbonne: widget.listFacture[id]
                                                    ['id_abonne']
                                                .toString(),
                                            nomAbonne: widget.listFacture[id]
                                                    ['nom_abonne']
                                                .toString(),
                                            prenomAbonne: widget.listFacture[id]
                                                    ['prenom_abonne']
                                                .toString(),
                                            cniAbonne: widget.listFacture[id]
                                                    ['cni_abonne']
                                                .toString(),
                                            telephoneAbonne: widget
                                                .listFacture[id]
                                                    ['telephone_abonne']
                                                .toString(),
                                            descriptionZoneAbonne: widget
                                                .listFacture[id]
                                                    ['description_zone_abonne']
                                                .toString(),
                                            secteurAbonne: widget
                                                .listFacture[id]
                                                    ['secteur_abonne']
                                                .toString(),
                                            typeAbonnement: widget
                                                .listFacture[id]
                                                    ['type_abonnement']
                                                .toString(),
                                            montant: widget.listFacture[id]
                                                    ['montant']
                                                .toString(),
                                            nombreChaine: widget.listFacture[id]
                                                    ['nombre_chaine']
                                                .toString(),
                                            createAt: widget.listFacture[id]
                                                    ['create_fm']
                                                .toString(),
                                          ),
                                        ));
                                  }),
                            ),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: MaterialButton(
                                  color: Palette.paiement,
                                  child: const CustomText(
                                      data: "Payement", color: Palette.white),
                                  onPressed: () {
                                    actionDialogue(
                                        child: PayementFacture(
                                          user: widget.users,
                                          facture: FactureModels(
                                            idFacture: widget.listFacture[id]
                                                    ['id_facture']
                                                .toString(),
                                            numeroFacture: widget
                                                .listFacture[id]
                                                    ['numero_facture']
                                                .toString(),
                                            mensualiteFacture: widget
                                                .listFacture[id]
                                                    ['mensualite_facture']
                                                .toString(),
                                            montantVerser: widget
                                                .listFacture[id]
                                                    ['montant_verser']
                                                .toString(),
                                            resteFacture: widget.listFacture[id]
                                                    ['reste_facture']
                                                .toString(),
                                            statutFacture: widget
                                                .listFacture[id]
                                                    ['statut_facture']
                                                .toString(),
                                            impayes: widget.listFacture[id]
                                                    ['impayes']
                                                .toString(),
                                            idAbonne: widget.listFacture[id]
                                                    ['id_abonne']
                                                .toString(),
                                            nomAbonne: widget.listFacture[id]
                                                    ['nom_abonne']
                                                .toString(),
                                            prenomAbonne: widget.listFacture[id]
                                                    ['prenom_abonne']
                                                .toString(),
                                            cniAbonne: widget.listFacture[id]
                                                    ['cni_abonne']
                                                .toString(),
                                            telephoneAbonne: widget
                                                .listFacture[id]
                                                    ['telephone_abonne']
                                                .toString(),
                                            descriptionZoneAbonne: widget
                                                .listFacture[id]
                                                    ['description_zone_abonne']
                                                .toString(),
                                            secteurAbonne: widget
                                                .listFacture[id]
                                                    ['secteur_abonne']
                                                .toString(),
                                            typeAbonnement: widget
                                                .listFacture[id]
                                                    ['type_abonnement']
                                                .toString(),
                                            montant: widget.listFacture[id]
                                                    ['montant']
                                                .toString(),
                                            nombreChaine: widget.listFacture[id]
                                                    ['nombre_chaine']
                                                .toString(),
                                            createAt: widget.listFacture[id]
                                                    ['created_at']
                                                .toString(),
                                          ),
                                        ),
                                        context: context);
                                  }),
                            ),
                          ])),
                        ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  dynamic selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        textDirection: TextDirection.ltr,
        initialEntryMode: DatePickerEntryMode.input,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = '${picked.day}-${picked.month}-${picked.year} ';
        Provider.of<HomeProvider>(context, listen: false)
            .searchInLIstFacture(selectedDate, 'create_fm');
      });
    }
  }
}
