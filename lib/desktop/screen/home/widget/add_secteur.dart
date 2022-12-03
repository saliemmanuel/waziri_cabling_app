import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/models/secteur.dart';

import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class AddSecteur extends StatefulWidget {
  const AddSecteur({super.key});

  @override
  State<AddSecteur> createState() => _AddSecteurState();
}

class _AddSecteurState extends State<AddSecteur> {
  var designation = TextEditingController();
  var description = TextEditingController();

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
              Column(
                children: [
                  CustumTextField(
                    child: "Désignation secteur",
                    obscureText: false,
                    controller: designation,
                  ),
                  CustumTextField(
                    child: "Description zône secteur",
                    obscureText: false,
                    controller: description,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustumButton(
                      enableButton: true,
                      child: "   Enregistrez   ",
                      bacgroundColor: Colors.teal,
                      onPressed: () async {
                        var secteur = Secteur(
                            id: 0,
                            designationSecteur: designation.text,
                            descriptionSecteur: description.text);
                        Provider.of<HomeProvider>(context, listen: false)
                            .addSecteur(secteur: secteur, context: context);
                        Provider.of<HomeProvider>(context, listen: false)
                            .provideListSecteur();
                      }),
                  CustumButton(
                      enableButton: true,
                      child: "   Annuler   ",
                      bacgroundColor: Colors.red,
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
