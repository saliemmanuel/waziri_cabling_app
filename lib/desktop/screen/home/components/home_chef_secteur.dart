import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';

import '../../../../config/config.dart';

class HomeChefSecteur extends StatelessWidget {
  const HomeChefSecteur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Container(
          height: double.infinity,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Palette.backgroundColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 45.0, right: 45.0),
                      child: AppBar(
                        title: const CustomText(
                            data: "Accueil", color: Colors.black),
                        elevation: 0.0,
                        backgroundColor: Palette.scaffold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Image.asset(
                          'assets/images/home_1.png',
                          height: 375,
                        ),
                      ),
                    )
                  ]))),
    );
  }
}
