import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/shimmer_table.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/accueil_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../provider/home_provider.dart';
import 'table_type_abonnement.dart';
import 'text.dart';

class Comptabilite extends StatelessWidget {
  final Users user;
  const Comptabilite({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .provideListeTypeAbonnement();
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
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                child: AppBar(
                  title: const CustomText(
                      data: "Comptabilité", color: Colors.black),
                  elevation: 0.0,
                  backgroundColor: Palette.scaffold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(spacing: 18.0, runSpacing: 18.0, children: const [
                    AccueilCard(containerColor: Colors.yellow),
                    AccueilCard(containerColor: Colors.pink),
                    AccueilCard(containerColor: Colors.blueGrey),
                    AccueilCard(containerColor: Colors.teal),
                  ]),
                ),
              ),
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
                          users: user,
                          listTypeAbonnement:
                              value.listTypeAbonnement['type_abonnement']);
                }),
              ),
              Container(
                  height: 350.0,
                  margin: const EdgeInsets.only(
                      top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.0)),
                  child: DataTable2SimpleDemo()),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                      spacing: 18.0,
                      runSpacing: 18.0,
                      children: List.generate(
                        4,
                        (index) => const AccueilCard(
                          containerColor: Colors.teal,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}
