import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../../global_widget/custom_text.dart';
import '../../../../models/users.dart';

class DetailUtilisateur extends StatelessWidget {
  final Users users;
  const DetailUtilisateur({super.key, required this.users});

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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "Nom et prénom", fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data:
                              "${users.nomUtilisateur!} ${users.prenomUtilisateur!}")),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "E-mail", fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(data: users.email!)),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "ezeze", fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(data: "ezez")),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 35.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          data: "Nombre abonnés secteur",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(data: "14")),
                ]))));
  }
}
