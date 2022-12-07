import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:waziri_cabling_app/desktop/screen/home/components/text.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_text.dart';

class Charges extends StatefulWidget {
  const Charges({super.key});

  @override
  State<Charges> createState() => _ChargesState();
}

class _ChargesState extends State<Charges> {
  @override
  Widget build(BuildContext context2) {
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
                title: const CustomText(data: "Charges", color: Colors.black),
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
                    child: DataTable2SimpleDemo()))
          ],
        ),
      ),
    );
  }
}
