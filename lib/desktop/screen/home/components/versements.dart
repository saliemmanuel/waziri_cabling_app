// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../provider/home_provider.dart';
import '../widget/app_header.dart';
import '../widget/shimmer_table.dart';
import '../widget/table_versement.dart';

class Versements extends StatefulWidget {
  final Users users;
  const Versements({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  State<Versements> createState() => _VersementsState();
}

class _VersementsState extends State<Versements> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).provideVersements();
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
            appHeader("Versements"),
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
                          child: value.listPannes == null
                              ? const ShimmerTable()
                              : TableVersement(
                                  users: widget.users,
                                  listVersements: value.listVersements),
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
