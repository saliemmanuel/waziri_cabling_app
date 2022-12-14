import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/shimmer_table.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/global_widget/card_tips.dart';

import '../../../../global_widget/custom_text.dart';
import '../../../../models/users.dart';
import '../widget/utilisateur_table.dart';
import 'text.dart';

class Utilisateurs extends StatefulWidget {
  final Users user;
  const Utilisateurs({super.key, required this.user});

  @override
  State<Utilisateurs> createState() => _UtilisateursState();
}

class _UtilisateursState extends State<Utilisateurs> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).providelistUtilisateur();
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
                actions: [
                  Consumer(
                    builder: (context, value, child) => CardTips(
                      icon: IconlyLight.user,
                      cardColors: Colors.grey,
                      iconColors: Colors.black,
                      title:
                          "${Provider.of<AuthProvider>(context).user.nomUtilisateur} ${Provider.of<AuthProvider>(context).user.prenomUtilisateur}",
                      titleColors: Colors.black,
                      onTap: () {},
                    ),
                  )
                ],
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
                                  userList:
                                      value.listUtilisateur['utilisateur'],
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
