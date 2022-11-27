import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/accueil_card.dart';
import '../../../../global_widget/custom_text.dart';
import 'text.dart';

class Comptabilite extends StatefulWidget {
  const Comptabilite({super.key});

  @override
  State<Comptabilite> createState() => _ComptabiliteState();
}

class _ComptabiliteState extends State<Comptabilite> {
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
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
              child: AppBar(
                title:
                    const CustomText(data: "Comptabilité", color: Colors.black),
                elevation: 0.0,
                backgroundColor: Palette.scaffold,
              ),
            ),
            Container(
                height: 450.0,
                margin: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0)),
                child: DataTable2SimpleDemo()),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                      spacing: 18.0,
                      runSpacing: 18.0,
                      children: List.generate(
                        80,
                        (index) => const AccueilCard(
                          containerColor: Colors.teal,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 50.0)
          ],
        ),
      ),
    );
  }
}
