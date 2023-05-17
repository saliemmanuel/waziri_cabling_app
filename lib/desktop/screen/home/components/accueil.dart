import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/config/config.dart';

import '../widget/app_header.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var homeScrollController = ScrollController();


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
          controller: homeScrollController,
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appHeader("Accueil"),
              Container(
                height: 400.0,
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(
                    left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0)),
                child: Image.asset(
                  'assets/images/logo_2.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
