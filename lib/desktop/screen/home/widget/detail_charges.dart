import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/models/charge_models.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class DetailCharges extends StatefulWidget {
  final ChargeModels chargeModels;
  const DetailCharges({super.key, required this.chargeModels});

  @override
  State<DetailCharges> createState() => _DetailChargesState();
}

class _DetailChargesState extends State<DetailCharges> {
  late TextEditingController designation;
  late TextEditingController description;
  late TextEditingController somme;
  dynamic selectedDate;
  ChargeModels? _chargeModels;

  bool? isActive = false;

  @override
  void initState() {
    designation =
        TextEditingController(text: widget.chargeModels.designationCharge);
    description =
        TextEditingController(text: widget.chargeModels.descriptionCharge);
    somme = TextEditingController(text: widget.chargeModels.sommeCharge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
        largeSize: 30,
        smallSize: 50,
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
                        data: "Détail charge",
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
                                CustomDetailWidget2(
                                  title: "Désignation charge",
                                  controller: designation,
                                  onChanged: (value) {
                                    valueIsChange();
                                  },
                                ),
                                CustomDetailWidget2(
                                  title: "Description charge",
                                  controller: description,
                                  onChanged: (value) {
                                    valueIsChange();
                                  },
                                ),
                              ]),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: Column(
                          children: [
                            CustomDetailWidget(
                              title: "Date versement",
                              nullVal: widget.chargeModels.dateCharge,
                              subtitle: selectedDate,
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                            CustomDetailWidget2(
                              title: "Somme versée",
                              controller: somme,
                              onChanged: (value) {
                                valueIsChange();
                              },
                            ),
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustumButton(
                          bacgroundColor:
                              isActive! ? Palette.teal : Colors.grey,
                          enableButton: isActive,
                          child: "  Enregistrez  ",
                          onPressed: () {},
                        ),
                        CustumButton(
                            enableButton: true,
                            child: "   Fermer   ",
                            bacgroundColor: Palette.red,
                            onPressed: () async {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ))),
        ));
  }

  valueIsChange() {
    _chargeModels = ChargeModels(
        id: widget.chargeModels.id,
        designationCharge: designation.text,
        descriptionCharge: description.text,
        dateCharge: selectedDate ?? widget.chargeModels.dateCharge,
        sommeCharge: somme.text);
    if (_chargeModels.toString() != widget.chargeModels.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = '${picked.day}-${picked.month}-${picked.year} ';
        valueIsChange();
      });
    }
  }
}
