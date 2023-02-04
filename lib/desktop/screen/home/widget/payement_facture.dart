import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';
import 'package:waziri_cabling_app/models/facture_models.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class PayementFacture extends StatefulWidget {
  final FactureModels facture;
  final Users user;
  const PayementFacture({super.key, required this.facture, required this.user});

  @override
  State<PayementFacture> createState() => _PayementFactureState();
}

class _PayementFactureState extends State<PayementFacture> {
  var montant = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomText(
                  data: "Espace de payement de facture",
                  color: Colors.red,
                  fontSize: 30.0),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      data: "FACTURE N0 : # ${widget.facture.numeroFacture}"),
                  CustomText(data: "Du :  ${widget.facture.createAt}"),
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
                            data: "Nom et prénom : ${widget.facture.nomAbonne}",
                          ),
                          CustomText(
                              data:
                                  "Type Abonnement : ${widget.facture.typeAbonnement}")
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
                            data:
                                "Téléphone : ${widget.facture.telephoneAbonne}",
                          ),
                          CustomText(
                            data:
                                "Nom de chaine : ${widget.facture.nombreChaine}",
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
                            data: "CNI : ${widget.facture.cniAbonne}",
                          ),
                          CustomText(
                            data:
                                "Montant Abonnement : ${widget.facture.montant}",
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
                        data: "Secteur : ${widget.facture.secteurAbonne}",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        data:
                            "Description : ${widget.facture.descriptionZoneAbonne}",
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
                          data: widget.facture.mensualiteFacture!,
                        ),
                      ),
                      DataCell(
                        CustomText(
                          data: widget.facture.montantVerser!,
                        ),
                      ),
                      DataCell(
                        CustomText(
                          data: widget.facture.resteFacture!,
                        ),
                      ),
                      DataCell(
                        CustomText(
                          data: widget.facture.statutFacture!,
                        ),
                      ),
                      DataCell(
                        CustomText(
                          data: widget.facture.impayes!,
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
                        "Net à payer : ${int.parse(widget.facture.impayes!) + int.parse(widget.facture.mensualiteFacture!)}",
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: CustumTextField(
                          controller: montant,
                          bacgroundColor: Palette.teal,
                          child: "Montant",
                          keyboardType: TextInputType.number,
                          obscureText: false),
                    ),
                  ),
                  CustumButton(
                      enableButton: true,
                      child: "   Enregistrez   ",
                      bacgroundColor: Palette.teal,
                      onPressed: () async {
                        var netAPayer = int.parse(widget.facture.impayes!) +
                            int.parse(widget.facture.mensualiteFacture!);
                        if (montant.text.isNotEmpty) {
                          if (int.parse(montant.text) > netAPayer) {
                            echecTransaction(
                                'Montant supérieur au Net à payer', context);
                          } else {
                            var reste = netAPayer - int.parse(montant.text);
                            Provider.of<HomeProvider>(context, listen: false)
                                .payementFacture(
                                    facture: FactureModels(
                                      idFacture:
                                          widget.facture.idFacture.toString(),
                                      numeroFacture: widget
                                          .facture.numeroFacture
                                          .toString(),
                                      mensualiteFacture: widget
                                          .facture.mensualiteFacture
                                          .toString(),
                                      montantVerser: montant.text.toString(),
                                      resteFacture: reste.toString(),
                                      statutFacture:
                                          netAPayer == int.parse(montant.text)
                                              ? 'Totalite'
                                              : 'Payer en partie',
                                      impayes:
                                          widget.facture.impayes.toString(),
                                      idAbonne:
                                          widget.facture.idAbonne.toString(),
                                      createAt:
                                          widget.facture.createAt.toString(),
                                    ),
                                    context: context);
                            Provider.of<HomeProvider>(context, listen: false)
                                .provideListeFacture(
                                    users: widget.user,
                                    selectedStatut: 'impayer');
                          }
                        } else {
                          echecTransaction('Entrez le montant svp!', context);
                        }
                      }),
                  CustumButton(
                      enableButton: true,
                      child: "   Fermer   ",
                      bacgroundColor: Palette.red,
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
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
