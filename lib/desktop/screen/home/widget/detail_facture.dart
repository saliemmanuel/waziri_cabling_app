import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/facture_models.dart';

class DetailFacture extends StatelessWidget {
  final FactureModels facture;

  const DetailFacture({super.key, required this.facture});

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context)),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Détail facture", color: Colors.red, fontSize: 30.0),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(data: "FACTURE N0 : # ${facture.numeroFacture}"),
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
                              data: "Nom et prénom : ${facture.nomAbonne}",
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
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                CustumButton(
                    enableButton: true,
                    child: "   Fermer   ",
                    bacgroundColor: Palette.red,
                    onPressed: () => Navigator.pop(context)),
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
                    ? Colors.transparent
                    : index % 2 == 0
                        ? Colors.transparent
                        : Colors.grey,
                height: 1,
                width: 0.5,
              ))),
    );
  }
}
