import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/components/abonnes.dart';
import 'package:waziri_cabling_app/desktop/screen/home/components/home_chef_secteur.dart';
import 'package:waziri_cabling_app/desktop/screen/home/components/secteurs.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../config/config.dart';
import '../../../global_widget/custom_dialogue_card.dart';
import '../../../global_widget/custom_pane_item.dart';
import 'components/accueil.dart';
import 'components/charges.dart';
import 'components/comptabilite.dart';
import 'components/factures.dart';
import 'components/materiel.dart';
import 'components/message.dart';
import 'components/pannes.dart';
import 'components/parametres.dart';
import 'components/utilisateur.dart';
import 'components/versements.dart';

class HomeDeskScreen extends StatefulWidget {
  final Users? users;
  const HomeDeskScreen({super.key, required this.users});

  @override
  State<HomeDeskScreen> createState() => _HomeDeskScreenState();
}

var code = TextEditingController();

class _HomeDeskScreenState extends State<HomeDeskScreen> {
  final comptaCode = "19586388911345317";
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).provideListSecteur();
    Provider.of<HomeProvider>(context, listen: false).provideCharge();
    Provider.of<HomeProvider>(context, listen: false).providePannes();
    Provider.of<HomeProvider>(context, listen: false).provideMessageMoi();
    Provider.of<HomeProvider>(context, listen: false)
        .provideListeAbonnes(users: widget.users);
    Provider.of<HomeProvider>(context, listen: false)
        .provideListeTypeAbonnement();
    if (widget.users!.roleUtilisateur != "chef-secteur") {
      Provider.of<HomeProvider>(context, listen: false).provideVersements();
      Provider.of<HomeProvider>(context, listen: false)
          .providelistUtilisateur('Tout les utilisateurs');
      Provider.of<HomeProvider>(context, listen: false).provideMateriels();
    }

    var listPage = [
      widget.users!.roleUtilisateur != "chef-secteur"
          ? const Accueil()
          : const HomeChefSecteur(),
      Utilisateurs(user: widget.users!),
      Materiel(users: widget.users!),
      Pannes(users: widget.users!),
      Factures(users: widget.users!),
      Abonne(users: widget.users!),
      Versements(users: widget.users!),
      Comptabilite(users: widget.users!),
      Charges(users: widget.users!),
      Message(users: widget.users!),
      Secteurs(users: widget.users!),
      Parametres(users: widget.users),
    ];
    var listItem = [
      CustomPaneItem(
          body: Text('Accueil', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.home, color: Colors.black),
          isSelected: true,
          selectedIcon:
              const Icon(IconlyBold.home, color: Palette.primaryColor),
          index: 0,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 0);
          }),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
            body: Text('Utilisateur',
                style: GoogleFonts.cabin(color: Colors.black)),
            icon: const Icon(IconlyLight.user_1, color: Colors.black),
            isSelected: false,
            selectedIcon:
                const Icon(IconlyBold.user_3, color: Palette.primaryColor),
            index: 1,
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .changeBody(index: 1);
            }),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
            body:
                Text('Secteurs', style: GoogleFonts.cabin(color: Colors.black)),
            icon: const Icon(IconlyLight.graph, color: Colors.black),
            selectedIcon:
                const Icon(IconlyBold.graph, color: Palette.primaryColor),
            isSelected: false,
            index: 10,
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .changeBody(index: 10);
            }),
      CustomPaneItem(
          body: Text('Abonnés', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.user_1, color: Colors.black),
          isSelected: false,
          selectedIcon:
              const Icon(IconlyBold.user_3, color: Palette.primaryColor),
          index: 5,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 5);
          }),
      CustomPaneItem(
          body: Text('Factures', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.document, color: Colors.black),
          isSelected: false,
          selectedIcon:
              const Icon(IconlyBold.document, color: Palette.primaryColor),
          index: 4,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 4);
          }),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
            body: Text('Versements',
                style: GoogleFonts.cabin(color: Colors.black)),
            icon: const Icon(IconlyLight.arrow_down, color: Colors.black),
            selectedIcon:
                const Icon(IconlyBold.arrow_down, color: Palette.primaryColor),
            isSelected: false,
            index: 6,
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .changeBody(index: 6);
            }),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
            body: Text('Comptabilté',
                style: GoogleFonts.cabin(color: Colors.black)),
            icon: const Icon(IconlyLight.chart, color: Colors.black),
            selectedIcon:
                const Icon(IconlyBold.chart, color: Palette.primaryColor),
            isSelected: false,
            index: 7,
            onPressed: () {
              getCodeAuth(
                  context: context,
                  onCall: () async {
                    if (code.text.isNotEmpty) {
                      if (code.text == comptaCode) {
                        Navigator.pop(context);
                        Provider.of<HomeProvider>(context, listen: false)
                            .changeBody(index: 7);
                        code.clear();
                      } else {
                        echecTransaction("Code incorrect", context);
                        code.clear();
                      }
                    } else {
                      echecTransaction("Entrez le code svp!", context);
                    }
                  });
            }),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
          body: Text('Charges', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.buy, color: Colors.black),
          isSelected: false,
          selectedIcon: const Icon(IconlyBold.buy, color: Palette.primaryColor),
          index: 8,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 8);
          },
        ),
      CustomPaneItem(
          body: Text('Pannes', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.paper_fail, color: Colors.black),
          selectedIcon:
              const Icon(IconlyBold.paper_fail, color: Palette.primaryColor),
          isSelected: false,
          index: 3,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 3);
          }),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
          body: Text('Message', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.message, color: Colors.black),
          selectedIcon:
              const Icon(IconlyBold.message, color: Palette.primaryColor),
          isSelected: false,
          index: 9,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 9);
          },
        ),
      if (widget.users!.roleUtilisateur != "chef-secteur")
        CustomPaneItem(
            body:
                Text('Matériel', style: GoogleFonts.cabin(color: Colors.black)),
            icon: const Icon(IconlyLight.category, color: Colors.black),
            selectedIcon:
                const Icon(IconlyBold.category, color: Palette.primaryColor),
            isSelected: false,
            index: 2,
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .changeBody(index: 2);
            }),
      CustomPaneItem(
          body:
              Text('Paramètres', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.setting, color: Colors.black),
          selectedIcon:
              const Icon(IconlyBold.setting, color: Palette.primaryColor),
          isSelected: false,
          index: 11,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false)
                .changeBody(index: 11);
          }),
    ];
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Consumer<AuthProvider>(builder: ((context, value, child) {
        return value.user.email == null
            ? const Center(
                child: CircularProgressIndicator(color: Palette.primaryColor))
            : Column(
                children: [
                  // const CustomWindowsButton(),
                  Expanded(
                      child: Row(
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          width: 200.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (var i = 0; i < listItem.length; i++)
                                  CustomPaneItem(
                                    icon: listItem[i].icon,
                                    body: listItem[i].body,
                                    isSelected:
                                        Provider.of<HomeProvider>(context)
                                                .topIndex ==
                                            listItem[i].index,
                                    index: listItem[i].index,
                                    onPressed: listItem[i].onPressed,
                                    selectedIcon: listItem[i].selectedIcon,
                                  ),
                              ]),
                        ),
                      ),
                      Expanded(child: Consumer<HomeProvider>(
                        builder: (context, value, child) {
                          return listPage[value.topIndex];
                        },
                      )),
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            data:
                                "© 2023 · BW-IMAGE - Application de Gestion de Cable. ${widget.users!.email ?? ""}",
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ],
              );
      })),
    );
  }
}
