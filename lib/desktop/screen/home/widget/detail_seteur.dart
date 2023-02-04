import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/models/secteur.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_button.dart';
import '../../../../global_widget/custom_detail_widget.dart';

class DetailSecteur extends StatelessWidget {
  final Secteur secteur;
  const DetailSecteur({super.key, required this.secteur});

  @override
  Widget build(BuildContext context) {
    return Badge(
        badgeContent: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                      data: "Détail matériel",
                      color: Colors.red,
                      fontSize: 30.0),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDetailWidget(
                                  title: "Désignation secteur",
                                  subtitle: secteur.designationSecteur),
                              CustomDetailWidget(
                                  title: "Description secteur",
                                  subtitle: secteur.descriptionSecteur),
                            ]),
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: Column(
                          children: [
                            CustomDetailWidget(
                                title: "Chef secteur",
                                subtitle: secteur.descriptionSecteur),
                            const SizedBox(height: 99.0),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  CustumButton(
                      enableButton: true,
                      child: "   Fermer   ",
                      bacgroundColor: Palette.red,
                      onPressed: () => Navigator.pop(context))
                ],
              ))),
        ));
  }
}
