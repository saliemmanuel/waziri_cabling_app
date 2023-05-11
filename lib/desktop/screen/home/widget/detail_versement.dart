import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/models/versement_models.dart';

import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_text.dart';

class DetailVersement extends StatefulWidget {
  final VersementModels versementModels;
  const DetailVersement({super.key, required this.versementModels});

  @override
  State<DetailVersement> createState() => _DetailVersementState();
}

class _DetailVersementState extends State<DetailVersement> {
  @override
  Widget build(BuildContext context) {
    return Badge(
        label: InkWell(
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
                                    title: "Nom Secteur",
                                    subtitle:
                                        widget.versementModels.nomSecteur),
                                CustomDetailWidget(
                                    title: "Nom chef sercteur",
                                    subtitle:
                                        widget.versementModels.nomChefSecteur),
                              ]),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: Column(
                          children: [
                            CustomDetailWidget(
                                title: "Date versement",
                                subtitle: widget.versementModels.dateVersement),
                            CustomDetailWidget(
                                title: "Somme verser",
                                subtitle: widget.versementModels.sommeVerser),
                          ],
                        ))
                      ],
                    ),
                  ],
                ),
              ))),
        ));
  }
}
