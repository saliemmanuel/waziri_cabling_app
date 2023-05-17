import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/message_moi_models.dart';
import '../provider/home_provider.dart';

class DetailMessageMois extends StatefulWidget {
  final MessageMoisModel messageMoisModel;
  const DetailMessageMois({super.key, required this.messageMoisModel});

  @override
  State<DetailMessageMois> createState() => _DetailMessageMoisState();
}

class _DetailMessageMoisState extends State<DetailMessageMois> {
  late TextEditingController designation;
  late TextEditingController corps;

  @override
  void initState() {
    designation = TextEditingController(
        text: widget.messageMoisModel.designationMessageMois);
    corps =
        TextEditingController(text: widget.messageMoisModel.corpsMessageMois);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      largeSize: 30,
      smallSize: 50,
      label: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      child: SizedBox(
        width: 850.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomText(
                    data: "Détail message mois",
                    color: Colors.red,
                    fontSize: 30.0),
                const SizedBox(height: 25.0),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Désignation message")),
                          ),
                          CustumTextField(
                              child: 'Désignation',
                              controller: designation,
                              obscureText: false),
                          const SizedBox(height: 10.0),
                          const SizedBox(height: 100.0)
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Corps message")),
                          ),
                          CustumTextField(
                              child: 'Corps message',
                              controller: corps,
                              obscureText: false),
                          const SizedBox(height: 10.0),
                          const SizedBox(height: 100.0)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustumButton(
                        enableButton: true,
                        child: "   Enregistrez   ",
                        bacgroundColor: Palette.teal,
                        onPressed: () async {
                          if (corps.text.isNotEmpty ||
                              designation.text.isNotEmpty) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .addMessageMois(
                                    messageMois: MessageMoisModel(
                                        id: "",
                                        designationMessageMois:
                                            designation.text,
                                        corpsMessageMois: corps.text),
                                    context: context);
                            Provider.of<HomeProvider>(context, listen: false)
                                .provideMessageMoi();
                          } else {
                            echecTransaction(
                                "Remplissez tous les champ svp!", context);
                          }
                        }),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
                        bacgroundColor: Palette.red,
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
