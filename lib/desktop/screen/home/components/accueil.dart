import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/global_widget/custom_text.dart';

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
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 45.0, right: 45.0),
                child: AppBar(
                  title: const CustomText(data: "Accueil", color: Colors.black),
                  elevation: 0.0,
                  backgroundColor: Palette.scaffold,
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(
              //       top: 20.0, left: 35.0, right: 40.0, bottom: 20.0),
              //   child: ListTile(
              //     title: CustomText(
              //         data: "Activité de la semaine", fontSize: 15.0),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Wrap(
              //       spacing: 18.0,
              //       runSpacing: 18.0,
              //       children: List.generate(
              //         8,
              //         (index) => AccueilCard(
              //           containerColor: Colors.teal,
              //           onPressed: () {},
              //         ),
              //       )),
              // ),
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
