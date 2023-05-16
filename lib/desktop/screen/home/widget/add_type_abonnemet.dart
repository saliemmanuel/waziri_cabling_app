import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/type_abonnement.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../provider/home_provider.dart';

class AddTypeAbonnement extends StatefulWidget {
  final Users users;
  const AddTypeAbonnement({super.key, required this.users});

  @override
  State<AddTypeAbonnement> createState() => _AddTypeAbonnementState();
}

class _AddTypeAbonnementState extends State<AddTypeAbonnement> {
  var designation = TextEditingController();
  var montant = TextEditingController();
  var nombreChaine = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Badge(
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
                    data: "Espace ajours type abonnement",
                    color: Colors.red,
                    fontSize: 30.0),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                    data: "Désignation type abonnement")),
                          ),
                          CustumTextField(
                              bacgroundColor: Palette.teal,
                              child: 'Désignation type abonnement',
                              controller: designation,
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Montant abonnement")),
                          ),
                          CustumTextField(
                              child: 'Montant abonnement',
                              controller: montant,
                              obscureText: false),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Nombre chaîne")),
                          ),
                          CustumTextField(
                              bacgroundColor: Palette.teal,
                              child: 'Nombre chaîne',
                              controller: nombreChaine,
                              obscureText: false),
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
                        enableButton: true,
                        child: "   Enregistrez   ",
                        bacgroundColor: Palette.teal,
                        onPressed: () {
                          Provider.of<HomeProvider>(context, listen: false)
                              .addTypeAbonnement(
                                  type: TypeAbonnement(
                                      id: 0,
                                      designationTypeAbonnement:
                                          designation.text,
                                      montant: montant.text,
                                      nombreChaine: nombreChaine.text,
                                      idInitiateur: widget.users.id.toString()),
                                  context: context);

                          designation.clear();
                          montant.clear();
                          nombreChaine.clear();

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
}
