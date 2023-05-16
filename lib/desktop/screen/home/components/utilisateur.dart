
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/shimmer_table.dart';
import 'package:waziri_cabling_app/config/config.dart';

import '../../../../global_widget/custom_text.dart';
import '../../../../models/users.dart';
import '../widget/utilisateur_table.dart';

class Utilisateurs extends StatefulWidget {
  final Users user;
  const Utilisateurs({super.key, required this.user});

  @override
  State<Utilisateurs> createState() => _UtilisateursState();
}

class _UtilisateursState extends State<Utilisateurs> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .providelistUtilisateur('Tout les utilisateurs');
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 45.0, right: 45.0),
              child: AppBar(
                title:
                    const CustomText(data: "Utilisateurs", color: Colors.black),
                elevation: 0.0,
                backgroundColor: Palette.scaffold,
              ),
            ),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Consumer<HomeProvider>(
                      builder: (context, value, child) {
                        return SizedBox(
                          child: value.listUtilisateur == null
                              ? const ShimmerTable()
                              : UserTable(
                                  userList: value.listUtilisateur,
                                  users: widget.user),
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
