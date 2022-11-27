// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconly/iconly.dart';
// import 'package:waziri_cabling_app/config/config.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/accueil.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/charges.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/comptabilite.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/factures.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/materiel.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/pannes.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/utilisateur.dart';
// import 'package:waziri_cabling_app/desktop/screen/home/components/versements.dart';
// import 'package:waziri_cabling_app/global_widget/custom_text.dart';
// import 'package:waziri_cabling_app/global_widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';
import 'package:window_manager/window_manager.dart';

import '../../../config/config.dart';
import '../../../global_widget/custom_dialogue_card.dart';
import '../../../global_widget/custom_pane_item.dart';
import '../../../global_widget/custom_window_button.dart';
import '../log/components/login_card.dart';
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
  const HomeDeskScreen({super.key});

  @override
  State<HomeDeskScreen> createState() => _HomeDeskScreenState();
}

int topIndex = 0;

class _HomeDeskScreenState extends State<HomeDeskScreen> {
  @override
  Widget build(BuildContext context) {
    print({Provider.of<AuthProvider>(context, listen: false).userIsLogged});
    var listPage = [
      const Accueil(),
      const Utilisateurs(),
      const Materiel(),
      const Pannes(),
      const Factures(),
      const Versements(),
      const Comptabilite(),
      const Charges(),
      const Message(),
      const Parametres(),
    ];
    var listItem = [
      CustomPaneItem(
          body: Text('Accueil', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.home, color: Colors.black),
          isSelected: true,
          index: 0,
          onPressed: () => setState(() => topIndex = 0)),
      CustomPaneItem(
          body: Text('Utilisateur',
              style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.user_1, color: Colors.black),
          isSelected: false,
          index: 1,
          onPressed: () => setState(() => topIndex = 1)),
      CustomPaneItem(
          body: Text('Matériel', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.category, color: Colors.black),
          isSelected: false,
          index: 2,
          onPressed: () => setState(() => topIndex = 2)),
      CustomPaneItem(
          body: Text('Pannes', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.paper_fail, color: Colors.black),
          isSelected: false,
          index: 3,
          onPressed: () => setState(() => topIndex = 3)),
      CustomPaneItem(
          body: Text('Factures', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.document, color: Colors.black),
          isSelected: false,
          index: 4,
          onPressed: () => setState(() => topIndex = 4)),
      CustomPaneItem(
          body:
              Text('Versements', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.arrow_down, color: Colors.black),
          isSelected: false,
          index: 5,
          onPressed: () => setState(() => topIndex = 5)),
      CustomPaneItem(
          body: Text('Comptabilté',
              style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.chart, color: Colors.black),
          isSelected: false,
          index: 6,
          onPressed: () async {
            setState(() {});
            var res = await getCodeAuth(context);
            if (res == "Valider") {
              setState(() => topIndex = 6);
            }
          }),
      CustomPaneItem(
        body: Text('Charges', style: GoogleFonts.cabin(color: Colors.black)),
        icon: const Icon(IconlyLight.buy, color: Colors.black),
        isSelected: false,
        index: 7,
        onPressed: () => setState(() => topIndex = 7),
      ),
      CustomPaneItem(
        body: Text('Message', style: GoogleFonts.cabin(color: Colors.black)),
        icon: const Icon(IconlyLight.message, color: Colors.black),
        isSelected: false,
        index: 8,
        onPressed: () => setState(() => topIndex = 8),
      ),
      CustomPaneItem(
          body: Text('Secteurs', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.graph, color: Colors.black),
          isSelected: false,
          index: 5,
          onPressed: () => setState(() => topIndex = 5)),
      CustomPaneItem(
          body:
              Text('Paramètres', style: GoogleFonts.cabin(color: Colors.black)),
          icon: const Icon(IconlyLight.setting, color: Colors.black),
          isSelected: false,
          index: 9,
          onPressed: () => setState(() => topIndex = 9)),
    ];
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Consumer(builder: ((context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomWindowsButton(),
            Expanded(
                child: Row(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    width: 200.0,
                    child: Column(children: [
                      for (var i = 0; i < listItem.length; i++)
                        CustomPaneItem(
                          icon: listItem[i].icon,
                          body: listItem[i].body,
                          isSelected: topIndex == listItem[i].index,
                          index: listItem[i].index,
                          onPressed: listItem[i].onPressed,
                        ),
                    ]),
                  ),
                ),
                Expanded(child: listPage[topIndex]),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      data:
                          "© 2022 · BW-IMAGE ‐ Application de Gestion de Cable. ${Provider.of<AuthProvider>(context, listen: false).userIsLogged}",
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
