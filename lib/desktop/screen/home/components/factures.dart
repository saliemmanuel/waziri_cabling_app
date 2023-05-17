import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/shimmer_table.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../widget/app_header.dart';
import '../widget/facture_table.dart';

class Factures extends StatefulWidget {
  final Users users;
  const Factures({super.key, required this.users});

  @override
  State<Factures> createState() => _FacturesState();
}

class _FacturesState extends State<Factures> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).provideListeFacture(
        users: widget.users, selectedStatut: 'Toute les factures');
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
            appHeader("Factures"),
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
                          child: value.listFactures == null
                              ? const ShimmerTable()
                              : FactureTable(
                                  listFacture: value.listTrie,
                                  users: widget.users),
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
