import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  var name = TextEditingController();
  var secondname = TextEditingController();
  var email = TextEditingController();
  var telephone = TextEditingController();
  var zone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      child: Padding(
        padding: const EdgeInsets.all(58.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const CustumTextField(
                      child: "Nom utilisateur", obscureText: false),
                  const CustumTextField(
                      child: "Prénom utilisateur", obscureText: false),
                  const CustumTextField(child: "E-mail", obscureText: false),
                  const CustumTextField(
                      child: "Tlephone_utilisateur", obscureText: false),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       bottom: 15.0, left: 10.0, right: 10.0),
                  //   child: ComboBox(
                  //     onChanged: (c) {},
                  //     isExpanded: true,
                  //     placeholder: const Text("Assignez son secteur"),
                  //     items: secteurs,
                  //   ),
                  // ),
                  const CustumTextField(
                      child: "zone_utilisateur", obscureText: false),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       bottom: 15.0, left: 10.0, right: 10.0),
                  //   child: ComboBox(
                  //     onChanged: (c) {},
                  //     isExpanded: true,
                  //     placeholder: const Text("Rôle utilisateur "),
                  //     items: secteurs,
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustumButton(
                      enableButton: true,
                      child: "   Enregistrez   ",
                      bacgroundColor: Colors.teal,
                      onPressed: () async {}),
                  CustumButton(
                      enableButton: true,
                      child: "   Annuler   ",
                      bacgroundColor: Colors.red,
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
