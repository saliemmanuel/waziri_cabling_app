import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/models/charge_models.dart';

import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_text.dart';

class DetailCharges extends StatefulWidget {
  final ChargeModels chargeModels;
  const DetailCharges({super.key, required this.chargeModels});

  @override
  State<DetailCharges> createState() => _DetailChargesState();
}

class _DetailChargesState extends State<DetailCharges> {
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
                                    title: "Désignation panne",
                                    subtitle:
                                        widget.chargeModels.designationCharge),
                                CustomDetailWidget(
                                    title: "Description panne",
                                    subtitle:
                                        widget.chargeModels.descriptionCharge),
                                CustomDetailWidget(
                                    title: "Date détection panne",
                                    subtitle: widget.chargeModels.dateCharge),
                              ]),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: Column(
                          children: [
                            CustomDetailWidget(
                                title: "Somme versée",
                                subtitle: widget.chargeModels.sommeCharge),
                            const SizedBox(height: 200.0),
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
