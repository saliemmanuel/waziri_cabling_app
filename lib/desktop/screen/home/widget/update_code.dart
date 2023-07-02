import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../log/provider/auth_provider.dart';
import '../provider/home_provider.dart';

class UpdateCodeAdministration extends StatefulWidget {
  const UpdateCodeAdministration({super.key});

  @override
  State<UpdateCodeAdministration> createState() =>
      _UpdateCodeAdministrationState();
}

class _UpdateCodeAdministrationState extends State<UpdateCodeAdministration> {
  var ancient = TextEditingController();
  var nouveau = TextEditingController();
  var confirm = TextEditingController();
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
                        data: "Modifier votre code",
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
                                    title: "Ancient code",
                                    controller: ancient,
                                    obscureText: true,
                                    onChanged: (value) {}),
                                CustomDetailWidget2(
                                    title: "Nouveau code",
                                    controller: nouveau,
                                    obscureText: true,
                                    onChanged: (value) {}),
                                CustomDetailWidget2(
                                    title: "Confirmer code",
                                    controller: confirm,
                                    obscureText: true,
                                    onChanged: (value) {}),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustumButton(
                          bacgroundColor: Palette.teal,
                          enableButton: true,
                          child: "  Enregistrez  ",
                          onPressed: () {
                            if (ancient.text.isEmpty ||
                                nouveau.text.isEmpty ||
                                confirm.text.isEmpty) {
                              echecTransaction(
                                  "Remplissez tous les champs svp!", context);
                            } else {
                              if (nouveau.text != confirm.text) {
                                echecTransaction(
                                    "Les deux mot de passe doivent être identique",
                                    context);
                              } else {
                                Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .updateCodeAdministration(
                                        context: context,
                                        id: Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .user
                                            .id,
                                        newcode: confirm.text,
                                        oldcode: ancient.text);
                              }
                            }
                          },
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
}
