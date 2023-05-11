import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../widget/abonnes_table.dart';
import '../widget/shimmer_table.dart';

class Abonne extends StatelessWidget {
  final Users users;
  const Abonne({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .provideListeAbonnes(users: users);
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
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 45.0,
                right: 45.0,
              ),
              child: AppBar(
                title: const CustomText(data: "Abonnés", color: Colors.black),
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
                      builder: (context, value, child) =>
                          value.listAbonnes == null
                              ? const ShimmerTable()
                              : AbonnesTable(
                                  abonnesList: value.listAbonnes,
                                  users: users,
                                ),
                    )))
          ],
        ),
      ),
    );
  }
}
