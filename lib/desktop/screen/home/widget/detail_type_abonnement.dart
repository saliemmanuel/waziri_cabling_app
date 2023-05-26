import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_button.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../models/type_abonnement.dart';
import '../../../../models/users.dart';

class DetailTypeAbonnement extends StatefulWidget {
  final Users users;
  final TypeAbonnement type;

  const DetailTypeAbonnement(
      {super.key, required this.users, required this.type});

  @override
  State<DetailTypeAbonnement> createState() => _DetailTypeAbonnementState();
}

class _DetailTypeAbonnementState extends State<DetailTypeAbonnement> {
  late TextEditingController designation;
  late TextEditingController montant;
  late TextEditingController nombreChaine;
  bool? isActive = false;
  TypeAbonnement? _type;

  @override
  void initState() {
    designation =
        TextEditingController(text: widget.type.designationTypeAbonnement);
    montant = TextEditingController(text: widget.type.montant);
    nombreChaine = TextEditingController(text: widget.type.nombreChaine);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 30,
      smallSize: 50,
      label: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      child: SizedBox(
        width: 750.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Ajout type abonnement",
                    color: Colors.red,
                    fontSize: 30.0),
                const SizedBox(height: 30.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomDetailWidget2(
                              title: 'Désignation type abonnement',
                              controller: designation,
                              onChanged: (value) {
                                valueIsChange();
                              }),
                          CustomDetailWidget2(
                              title: 'Montant abonnement',
                              controller: montant,
                              onChanged: (value) {
                                valueIsChange();
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        children: [
                          CustomDetailWidget2(
                              title: 'Nombre chaîne',
                              controller: nombreChaine,
                              onChanged: (value) {
                                valueIsChange();
                              }),
                          const SizedBox(height: 100.0),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustumButton(
                        bacgroundColor: isActive! ? Palette.teal : Colors.grey,
                        enableButton: isActive,
                        child: "   Enregistrez   ",
                        onPressed: () {
                          if (_type.toString() != widget.type.toString()) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .getUpdateTypeAbonnement(
                                    type: _type, context: context);
                          }

                          Provider.of<HomeProvider>(context, listen: false)
                              .provideListeTypeAbonnement();
                        }),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
                        bacgroundColor: Palette.red,
                        onPressed: () => Navigator.pop(context)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  valueIsChange() {
    _type = TypeAbonnement(
        id: widget.type.id,
        designationTypeAbonnement: designation.text,
        montant: montant.text,
        nombreChaine: nombreChaine.text,
        idInitiateur: widget.users.id.toString());
    if (_type.toString() != widget.type.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}
