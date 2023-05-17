import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../models/users.dart';
import '../provider/home_provider.dart';
import '../widget/app_header.dart';
import '../widget/shimmer_table.dart';
import '../widget/table_charge.dart';

class Charges extends StatefulWidget {
  final Users users;

  const Charges({super.key, required this.users});

  @override
  State<Charges> createState() => _ChargesState();
}

class _ChargesState extends State<Charges> {
  @override
  Widget build(BuildContext context2) {
    Provider.of<HomeProvider>(context, listen: false).provideCharge();
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
            appHeader("Charges"),
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
                              : TableCharge(
                                  users: widget.users,
                                  listCharge: value.listCharge),
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
