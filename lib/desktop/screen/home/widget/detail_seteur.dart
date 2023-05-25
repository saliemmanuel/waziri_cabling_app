import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/models/secteur.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_button.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_text_field2.dart';
import '../../../../models/users.dart';
import '../provider/home_provider.dart';

class DetailSecteur extends StatefulWidget {
  final Secteur secteur;
  const DetailSecteur({super.key, required this.secteur});

  @override
  State<DetailSecteur> createState() => _DetailSecteurState();
}

class _DetailSecteurState extends State<DetailSecteur> {
  late TextEditingController designation;
  late TextEditingController description;
  Users? users;
  late String? nomChefSecteur;
  bool? isActive = false;
  Secteur? _secteur;

  late String? idChefSecteur;

  List? listUtilisateur = [];

  @override
  void initState() {
    designation =
        TextEditingController(text: widget.secteur.designationSecteur);
    description =
        TextEditingController(text: widget.secteur.descriptionSecteur);
    nomChefSecteur = widget.secteur.nomChefSecteur;
    idChefSecteur = widget.secteur.idChefSecteur;
    initListUser();
    super.initState();
  }

  initListUser() async {
    List list =
        await Provider.of<HomeProvider>(context, listen: false).listUtilisateur;

    if (list != []) {
      for (var i = 0; i < list.length; i++) {
        listUtilisateur!.add(
            '${list[i]['id']} - ${list[i]['nom_utilisateur']} ${list[i]['prenom_utilisateur']}');
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .providelistUtilisateur('Tout les utilisateurs');
    return Badge(
        largeSize: 30,
        smallSize: 50,
        label: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDetailWidget2(
                                title: "Désignation secteur",
                                controller: designation,
                                onChanged: (value) {
                                  valueIsChange();
                                },
                              ),
                              CustumTextField2(
                                height: 150.0,
                                child: "Description secteur",
                                obscureText: false,
                                controller: description,
                                onChanged: (value) {
                                  valueIsChange();
                                },
                              ),
                            ]),
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                          child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Responsable secteur")),
                          ),
                          Consumer<HomeProvider>(
                            builder: ((context, value, child) => value
                                        .listUtilisateur ==
                                    null
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                        color: Palette.primaryColor))
                                : Container(
                                    height: 55.5,
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 10.0, bottom: 15.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: Palette.primaryColor)),
                                    child: Center(
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: CustomText(
                                                  data: nomChefSecteur!)),
                                          dropdownColor: Colors.white,
                                          items: listUtilisateur!
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                    value: e,
                                                    child: Text(
                                                        e
                                                            .toString()
                                                            .split('-')[1],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ))
                                              .toList(),
                                          onChanged: (user) {
                                            nomChefSecteur =
                                                user!.split('-')[1];
                                            idChefSecteur = user.split('-')[0];
                                            valueIsChange();
                                            setState(() {});
                                          }),
                                    ),
                                  )),
                          ),
                          const SizedBox(height: 165.0),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustumButton(
                        bacgroundColor: isActive! ? Palette.teal : Colors.grey,
                        enableButton: isActive,
                        child: "  Enregistrez  ",
                        onPressed: () {
                          if (_secteur.toString() !=
                              widget.secteur.toString()) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .getUpadeteSecteur(
                                    secteur: _secteur, context: context);
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
              ))),
        ));
  }

  valueIsChange() {
    _secteur = Secteur(
        id: widget.secteur.id,
        designationSecteur: designation.text,
        descriptionSecteur: description.text,
        nomChefSecteur: nomChefSecteur!,
        idChefSecteur: idChefSecteur!);
    if (_secteur.toString() != widget.secteur.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}
