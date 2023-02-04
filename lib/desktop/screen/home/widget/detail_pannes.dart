import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/global_widget/custom_detail_widget.dart';
import 'package:waziri_cabling_app/models/pannes_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_button.dart';
import '../../../../global_widget/custom_text.dart';

class DetailPannes extends StatefulWidget {
  final PannesModels pannes;
  const DetailPannes({super.key, required this.pannes});

  @override
  State<DetailPannes> createState() => _DetailPannesState();
}

class _DetailPannesState extends State<DetailPannes> {
  @override
  Widget build(BuildContext context) {
    return Badge(
        badgeContent: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800.0,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDetailWidget(
                                    title: "Désignation panne",
                                    subtitle: widget.pannes.designation),
                                CustomDetailWidget(
                                    title: "Description panne",
                                    subtitle: widget.pannes.description),
                                CustomDetailWidget(
                                    title: "Date détection panne",
                                    subtitle: widget.pannes.detectedDate),
                              ]),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                            child: Column(
                          children: [
                            CustomDetailWidget(
                                title: "Date resolution panne",
                                subtitle: widget.pannes.secteur),
                            const SizedBox(height: 100.0),
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
                        bacgroundColor: Palette.red,
                        onPressed: () => Navigator.pop(context))
                  ],
                ),
              ))),
        ));
  }
}
