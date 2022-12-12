import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/models/secteur.dart';

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
        child: Padding(
            padding: const EdgeInsets.all(58.0),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "Désignation secteur",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(data: secteur.designationSecteur)),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "Description secteur",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomText(data: secteur.descriptionSecteur),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "Chef secteur", fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(data: secteur.designationSecteur)),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "Nombre abonnés secteur",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(data: secteur.nomChefSecteur)),
                ]))));
  }
}
