import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/table_pannes.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../models/users.dart';
import '../provider/home_provider.dart';
import '../widget/shimmer_table.dart';

class Pannes extends StatefulWidget {
  final Users users;
  const Pannes({super.key, required this.users});

  @override
  State<Pannes> createState() => _PannesState();
}

class _PannesState extends State<Pannes> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).providePannes();
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
                title: const CustomText(data: "Pannes", color: Colors.black),
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
                          child: value.listPannes == null
                              ? const ShimmerTable()
                              : TablePannes(
                                  users: widget.users,
                                  listPannes: value.listPannes),
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
