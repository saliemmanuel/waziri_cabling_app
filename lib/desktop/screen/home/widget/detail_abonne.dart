import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class DetailAbonne extends StatelessWidget {
  final AbonneModels abonne;
  const DetailAbonne({super.key, required this.abonne});

  @override
  Widget build(BuildContext context) {
    return Badge(
        label: InkWell(
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
                children: [
                  const CustomText(
                      data: "Détail Abonné", color: Colors.red, fontSize: 30.0),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDetailWidget(
                                  title: "Nom abonné",
                                  subtitle: abonne.nomAbonne),
                              CustomDetailWidget(
                                  title: "Prénom abonné",
                                  subtitle: abonne.prenomAbonne),
                              CustomDetailWidget(
                                  title: "cni abonné",
                                  subtitle: abonne.cniAbonne),
                              CustomDetailWidget(
                                  title: "Téléphone abonné",
                                  subtitle: abonne.telephoneAbonne),
                            ]),
                      ),
                      const SizedBox(width: 25.0),
                      Expanded(
                        child: Column(
                          children: [
                            CustomDetailWidget(
                                title: "Type abonnement",
                                subtitle: abonne.typeAbonnement),
                            CustomDetailWidget(
                                title: "Secteur abonné",
                                subtitle: abonne.secteurAbonne),
                            CustomDetailWidget(
                                title: "Description zône abonné",
                                subtitle: abonne.descriptionZoneAbonne),
                            const SizedBox(height: 100.0),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ))),
        ));
  }
}
