import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/shimmer_table.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/accueil_card.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/widget.dart';
import '../home_desk_screen.dart';
import '../provider/home_provider.dart';
import '../widget/app_header.dart';
import '../widget/table_type_abonnement.dart';

class Comptabilite extends StatefulWidget {
  final Users users;
  const Comptabilite({super.key, required this.users});

  @override
  State<Comptabilite> createState() => _ComptabiliteState();
}

class _ComptabiliteState extends State<Comptabilite> {
  final comptaCode = "19586388911345317";

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).provideComptabiliteData();
    Provider.of<HomeProvider>(context, listen: false)
        .provideListeTypeAbonnement();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              appHeader("Comptabilité"),
              Consumer<HomeProvider>(
                builder: (context, value, child) => value.listComptaData == null
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child:
                              Wrap(spacing: 18.0, runSpacing: 18.0, children: [
                            AccueilCard(
                                label: "Total Recette ",
                                data: value.listComptaData!['recette'],
                                containerColor: Colors.yellow),
                            AccueilCard(
                                label: "Total Sorties ",
                                data: value.listComptaData!['sorties'],
                                containerColor: Colors.pink),
                            AccueilCard(
                                label: "Total Entrées ",
                                data: value.listComptaData!['entrees'],
                                containerColor: Colors.blueGrey),
                            AccueilCard(
                                label: "Total Dettes  ",
                                data: value.listComptaData!['dettes'],
                                containerColor: Colors.teal),
                          ]),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 30.0, right: 40.0, bottom: 20.0),
                child: Row(
                  children: [
                    CustumButton(
                      bacgroundColor: Palette.teal,
                      enableButton: true,
                      child: "   Reintialiser   ",
                      onPressed: () {
                        getCodeAuth(
                            context: context,
                            onCall: () async {
                              if (code.text.isNotEmpty) {
                                if (code.text == comptaCode) {
                                  Navigator.pop(context);
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .provideReinitComptabilite(
                                          context: context);
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .provideComptabiliteData();

                                  code.clear();
                                } else {
                                  echecTransaction("Code incorrect", context);
                                  code.clear();
                                }
                              } else {
                                echecTransaction(
                                    "Entrez le code svp!", context);
                              }
                            });
                      },
                    )
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: 350.0,
                margin: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0)),
                child: Consumer<HomeProvider>(builder: (context, value, child) {
                  return value.listTypeAbonnement == null
                      ? const ShimmerTable()
                      : TableTypeAbonnement(
                          users: widget.users,
                          listTypeAbonnement: value.listTypeAbonnement);
                }),
              ),
              const SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
