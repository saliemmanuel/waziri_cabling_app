import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/models/secteur.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/custom_text_field2.dart';
import '../../../../global_widget/widget.dart';

class AddSecteur extends StatefulWidget {
  final Users users;
  const AddSecteur({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  State<AddSecteur> createState() => _AddSecteurState();
}

class _AddSecteurState extends State<AddSecteur> {
  var designation = TextEditingController();
  var description = TextEditingController();
  Users? users;
  String nomChefSecteur = 'Nom responsable';
  String idChefSecteur = '';

  List? listUtilisateur = [];

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false)
        .providelistUtilisateur('Tout les utilisateurs');
    initListUser();
    super.initState();
  }

  initListUser() async {
    List list =
        await Provider.of<HomeProvider>(context, listen: false).listUtilisateur;
    if (list != []) {
      print(list);
      for (var i = 0; i < list.length; i++) {
        listUtilisateur!.add(
            '${list[i]['id']} - ${list[i]['nom_utilisateur']} ${list[i]['prenom_utilisateur']}');
      }
    }
    setState(() {});
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
        width: 750.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Ajout Secteur", color: Colors.red, fontSize: 30.0),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Désigantion secteur")),
                          ),
                          CustumTextField(
                            child: "Désignation secteur",
                            obscureText: false,
                            controller: designation,
                          ),
                          const SizedBox(height: 10.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                    data: "Description zône secteur")),
                          ),
                          CustumTextField2(
                            height: 150.0,
                            child: "Description zône secteur",
                            obscureText: false,
                            controller: description,
                          ),
                        ],
                      ),
                    ),
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                                data: nomChefSecteur)),
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
                                                          color: Colors.black)),
                                                ))
                                            .toList(),
                                        onChanged: (user) {
                                          nomChefSecteur = user!.split('-')[1];
                                          idChefSecteur = user.split('-')[0];
                                          setState(() {});
                                        }),
                                  ),
                                )),
                        ),
                        const SizedBox(height: 202.0),
                      ],
                    ))
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
                            id: "",
                            designationSecteur: designation.text,
                            descriptionSecteur: description.text,
                            nomChefSecteur: nomChefSecteur,
                            idChefSecteur: idChefSecteur,
                          );

                          Provider.of<HomeProvider>(context, listen: false)
                              .addSecteur(secteur: secteur, context: context);
                          Provider.of<HomeProvider>(context, listen: false)
                              .provideListSecteur();
                          designation.clear();
                          description.clear();
                          nomChefSecteur = 'Nom responsable';
                          setState(() {});
                        }),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
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
      ),
    );
  }
}
