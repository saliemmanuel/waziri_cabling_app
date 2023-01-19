import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/models/abonne_models.dart';

import '../../../../global_widget/custom_text.dart';

class DetailAbonne extends StatelessWidget {
  final AbonneModels abonne;
  const DetailAbonne({super.key, required this.abonne});

  @override
  Widget build(BuildContext context) {
    return Badge(
        badgeContent: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          child: Padding(
              padding: const EdgeInsets.all(58.0),
              child: SingleChildScrollView(
                  child: Row(
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  data: "Nom abonné",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(data: abonne.nomAbonne)),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  data: "Prénom abonné",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(data: abonne.prenomAbonne)),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  data: "cni abonné",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(data: abonne.cniAbonne)),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  data: "Téléphone",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(data: abonne.telephoneAbonne)),
                        ]),
                  ),
                  const SizedBox(width: 25.0),
                  Expanded(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                data: "Type abonnement",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(data: abonne.typeAbonnement)),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                data: "Secteur abonné",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(data: abonne.secteurAbonne)),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                data: "Description zône abonné",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child:
                                CustomText(data: abonne.descriptionZoneAbonne)),
                        const SizedBox(height: 125.0),
                      ],
                    ),
                  )
                ],
              ))),
        ));
  }
}
