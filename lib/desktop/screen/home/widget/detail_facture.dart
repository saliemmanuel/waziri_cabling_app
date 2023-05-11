import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../models/facture_models.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'generate_pdf/facture_pdf_api.dart';

class DetailFacture extends StatelessWidget {
  final Users users;
  final FactureModels facture;

  const DetailFacture({super.key, required this.facture, required this.users});

  @override
  Widget build(BuildContext context) {
    var factureApi = FacturePdfApi();
    return Badge(
      label: InkWell(
          child: const Icon(Icons.close, color: Palette.white),
          onTap: () => Navigator.pop(context)),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomText(
                        data: "Détail facture",
                        color: Palette.red,
                        fontSize: 30.0),
                    const SizedBox(width: 300.0),
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
                                var res = await Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .codeAuth(
                                        idAmin: users.id.toString(),
                                        code: code.text.toString(),
                                        context: context);
                                if (res) {
                                  // ignore: use_build_context_synchronously
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .provideListeFacture(
                                          users: users,
                                          selectedStatut: 'impayer');
                                  // ignore: use_build_context_synchronously
                                  await factureApi.generateFacture(
                                      title:
                                          'facture_${facture.nomAbonne} ${facture.prenomAbonne}_du_${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}.pdf',
                                      [facture.toMap()],
                                      context);
                                  code.clear();
                                }
                              } else {
                                echecTransaction(
                                    "Entrez le code svp!", context);
                              }
                            });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(data: "FACTURE N° : ${facture.numeroFacture}"),
                    CustomText(data: "Du :  ${facture.createAt}"),
                  ],
                ),
                const SizedBox(height: 20.0),
                dotLine(),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              data:
                                  "Nom et prénom : ${facture.nomAbonne} ${facture.prenomAbonne}",
                            ),
                            CustomText(
                                data:
                                    "Type Abonnement : ${facture.typeAbonnement}")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              data: "Téléphone : ${facture.telephoneAbonne}",
                            ),
                            CustomText(
                              data: "Nom de chaine : ${facture.nombreChaine}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              data: "CNI : ${facture.cniAbonne}",
                            ),
                            CustomText(
                              data: "Montant Abonnement : ${facture.montant}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          data: "Secteur : ${facture.secteurAbonne}",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          data:
                              "Description : ${facture.descriptionZoneAbonne}",
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    dotLine(),
                    const SizedBox(height: 15.0),
                    DataTable(columns: const [
                      DataColumn(label: CustomText(data: "Mensualité ")),
                      DataColumn(label: CustomText(data: "Montant verser ")),
                      DataColumn(label: CustomText(data: "Reste facture ")),
                      DataColumn(label: CustomText(data: "Statut ")),
                      DataColumn(label: CustomText(data: "Impayers ")),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(
                          CustomText(
                            data: facture.mensualiteFacture!,
                          ),
                        ),
                        DataCell(
                          CustomText(
                            data: facture.montantVerser!,
                          ),
                        ),
                        DataCell(
                          CustomText(
                            data: facture.resteFacture!,
                          ),
                        ),
                        DataCell(
                          CustomText(
                            data: facture.statutFacture!,
                          ),
                        ),
                        DataCell(
                          CustomText(
                            data: facture.impayes!,
                          ),
                        ),
                      ])
                    ]),
                  ],
                ),
                const SizedBox(height: 15.0),
                dotLine(),
                const SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      data:
                          "Net à payer : ${int.parse(facture.impayes!) + int.parse(facture.mensualiteFacture!)}",
                      color: Palette.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 35.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dotLine() {
    return Row(
      children: List.generate(
          100,
          (index) => Expanded(
                  child: Container(
                color: index == 0
                    ? Palette.transparent
                    : index % 2 == 0
                        ? Palette.transparent
                        : Palette.grey,
                height: 1,
                width: 0.5,
              ))),
    );
  }
}
