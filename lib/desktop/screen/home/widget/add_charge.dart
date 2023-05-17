import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/charge_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../provider/home_provider.dart';

class AddCharge extends StatefulWidget {
  const AddCharge({super.key});

  @override
  State<AddCharge> createState() => _AddChargeState();
}

class _AddChargeState extends State<AddCharge> {
  var designation = TextEditingController();
  var description = TextEditingController();
  var somme = TextEditingController();
  dynamic selectedDate;

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 30,
      smallSize: 50,
      label: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
          Provider.of<HomeProvider>(context, listen: false).provideCharge();
        },
      ),
      child: SizedBox(
        width: 850.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Ajout charge", color: Colors.red, fontSize: 30.0),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Désignation charge")),
                          ),
                          CustumTextField(
                              child: 'Désignation',
                              controller: designation,
                              obscureText: false),
                          const SizedBox(height: 10.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Somme verser")),
                          ),
                          CustumTextField(
                              child: 'Somme',
                              controller: somme,
                              obscureText: false),
                          const SizedBox(height: 100.0)
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Desciption charge")),
                          ),
                          CustumTextField(
                              child: 'Description',
                              controller: description,
                              obscureText: false),
                          const SizedBox(height: 10.0),
                          CustomDetailWidget(
                            title: "Date versement",
                            nullVal: "Date",
                            subtitle: selectedDate,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          const SizedBox(height: 100.0)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustumButton(
                        enableButton: true,
                        child: "   Enregistrez   ",
                        bacgroundColor: Palette.teal,
                        onPressed: () async {
                          if (description.text.isNotEmpty ||
                              designation.text.isNotEmpty ||
                              selectedDate != null ||
                              somme.text.isNotEmpty) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .addCharge(
                                    charge: ChargeModels(
                                        id: "",
                                        designationCharge: designation.text,
                                        descriptionCharge: description.text,
                                        dateCharge: selectedDate,
                                        sommeCharge: somme.text.toString()),
                                    context: context);
                            Provider.of<HomeProvider>(context, listen: false)
                                .provideCharge();
                            designation.clear();
                            description.clear();
                            somme.clear();
                            selectedDate = null;
                            designation.clear();
                          } else {
                            echecTransaction(
                                "Remplissez tous les champ svp!", context);
                          }
                        }),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
                        bacgroundColor: Palette.red,
                        onPressed: () async {
                          Navigator.pop(context);
                          Provider.of<HomeProvider>(context, listen: false)
                              .provideMateriels();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
      });
    }
  }
}
