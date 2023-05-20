// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/fluent_icon.dart';
import '../../../../models/facture_models.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import 'generate_pdf/facture_pdf_api.dart';

class DetailFacture extends StatefulWidget {
  final Users users;
  final FactureModels facture;

  const DetailFacture({super.key, required this.facture, required this.users});

  @override
  State<DetailFacture> createState() => _DetailFactureState();
}

class _DetailFactureState extends State<DetailFacture> {
  dynamic more;
  FactureModels? tmp;
  var factureApi = FacturePdfApi();

  @override
  void initState() {
    // tmp = FactureModels.fromMap(tmp!.toMap());
    initData();
    super.initState();
  }

  initData() async {
    tmp = widget.facture;
    more = await Provider.of<HomeProvider>(context, listen: false)
        .getDetailFacture(context: context, idAbonne: tmp!.idAbonne);
    print(more);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 30,
      smallSize: 50,
      label: InkWell(
          child: const Icon(Icons.close, color: Palette.white),
          onTap: () => Navigator.pop(context)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                                data: "Détail facture",
                                color: Palette.red,
                                fontSize: 30.0),
                            SizedBox(width: 300.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 100.0, top: 50.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                data:
                                    "FACTURE N° : ${tmp!.numeroFacture} \n\nDu :  ${tmp!.createAt}"),
                            InkWell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 35.0,
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Palette.teal),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Icon(
                                    printIcon,
                                    color: Palette.teal,
                                  )),
                              onTap: () {
                                getCodeAuth(
                                    context: context,
                                    onCall: () async {
                                      if (code.text.isNotEmpty) {
                                        var res =
                                            await Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false)
                                                .codeAuth(
                                                    idAmin: widget.users.id
                                                        .toString(),
                                                    code: code.text.toString(),
                                                    context: context);
                                        if (res) {
                                          Provider.of<HomeProvider>(context,
                                                  listen: false)
                                              .provideListeFacture(
                                                  users: widget.users,
                                                  selectedStatut: 'impayer');
                                          await factureApi.generateFacture(
                                              title:
                                                  'facture_${tmp!.nomAbonne} ${tmp!.prenomAbonne}_du_${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}.pdf',
                                              [tmp!.toMap()],
                                              context);
                                          code.clear();
                                        }
                                      } else {
                                        echecTransaction(
                                          "Entrez le code svp!",
                                          context,
                                        );
                                      }
                                    });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        dotLine(),
                        const SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, top: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      data:
                                          "Nom et prénom : ${tmp!.nomAbonne} ${tmp!.prenomAbonne}",
                                    ),
                                    CustomText(
                                        data:
                                            "Type Abonnement : ${tmp!.typeAbonnement}")
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      data:
                                          "Téléphone : ${tmp!.telephoneAbonne}",
                                    ),
                                    CustomText(
                                      data:
                                          "Nom de chaine : ${tmp!.nombreChaine}",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      data: "CNI : ${tmp!.cniAbonne}",
                                    ),
                                    CustomText(
                                      data:
                                          "Montant Abonnement : ${tmp!.montant}",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      data: "Secteur : ${tmp!.secteurAbonne}",
                                    ),
                                    CustomText(
                                      data:
                                          "Description : ${tmp!.descriptionZoneAbonne}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            dotLine(),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DataTable(columns: const [
                                  DataColumn(
                                      label: CustomText(data: "Mensualité ")),
                                  DataColumn(
                                      label:
                                          CustomText(data: "Montant verser ")),
                                  DataColumn(
                                      label:
                                          CustomText(data: "Reste facture ")),
                                  DataColumn(
                                      label: CustomText(data: "Statut ")),
                                  DataColumn(
                                      label: CustomText(data: "Impayers ")),
                                ], rows: [
                                  DataRow(cells: [
                                    DataCell(
                                      CustomText(
                                        data: tmp!.mensualiteFacture!,
                                      ),
                                    ),
                                    DataCell(
                                      CustomText(
                                        data: tmp!.montantVerser!,
                                      ),
                                    ),
                                    DataCell(
                                      CustomText(
                                        data: tmp!.resteFacture!,
                                      ),
                                    ),
                                    DataCell(
                                      CustomText(
                                        data: tmp!.statutFacture!,
                                      ),
                                    ),
                                    DataCell(
                                      CustomText(
                                        data: tmp!.impayes!,
                                      ),
                                    ),
                                  ])
                                ]),
                              ],
                            ),
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
                                  "Net à payer : ${int.parse(tmp!.impayes!) + int.parse(tmp!.mensualiteFacture!)}",
                              color: Palette.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 500.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 35.0,
                                width: 200.0,
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Palette.teal),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      onChanged: (value) {},
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search'),
                                    )),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(IconlyBold.search,
                                          color: Palette.grey),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              more == null
                                  ? const CircularProgressIndicator()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          more == null ? 0 : more!.length,
                                      itemBuilder: (_, index) {
                                        var fact =
                                            FactureModels.fromMap(more[index]);
                                        return Card(
                                            child: ListTile(
                                          leading: const Icon(
                                              Icons.file_copy_rounded,
                                              color: Palette.teal,
                                              size: 30.0),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  data:
                                                      "FACTURE N° : ${fact.numeroFacture}"),
                                              CustomText(
                                                  data:
                                                      "Du :  ${fact.createAt}"),
                                            ],
                                          ),
                                          onTap: () {
                                            tmp = fact;
                                            setState(() {});
                                          },
                                        ));
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
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
