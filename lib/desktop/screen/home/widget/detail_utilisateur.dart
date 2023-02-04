import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../../global_widget/custom_detail_widget.dart';
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
        child: SizedBox(
          width: 800.0,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                      data: "Détail utilisateur",
                      color: Colors.red,
                      fontSize: 30.0),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDetailWidget(
                                  title: "Nom et prénom",
                                  subtitle:
                                      "${users.nomUtilisateur!} ${users.prenomUtilisateur!}"),
                              CustomDetailWidget(
                                  title: "E-mail", subtitle: users.email!),
                              CustomDetailWidget(
                                  title: "Téléphone",
                                  subtitle: users.telephoneUtilisateur!),
                            ]),
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                          child: Column(
                        children: [
                          CustomDetailWidget(
                              title: "Rôle", subtitle: users.roleUtilisateur!),
                          CustomDetailWidget(
                              title: "Secteur",
                              subtitle: users.zoneUtilisateur!),
                          const SizedBox(height: 100.0)
                        ],
                      ))
                    ],
                  ),
                ],
              ))),
        ));
  }
}
