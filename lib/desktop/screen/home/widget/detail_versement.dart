import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/models/versement_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_detail_widget.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../provider/home_provider.dart';

class DetailVersement extends StatefulWidget {
  final VersementModels versementModels;
  const DetailVersement({super.key, required this.versementModels});

  @override
  State<DetailVersement> createState() => _DetailVersementState();
}

class _DetailVersementState extends State<DetailVersement> {
  late TextEditingController somme;
  bool? isActive = false;
  VersementModels? _versementModels;

  @override
  void initState() {
    somme = TextEditingController(text: widget.versementModels.sommeVerser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
        largeSize: 30,
        smallSize: 50,
        label: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800.0,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomText(
                        data: "Détail matériel",
                        color: Colors.red,
                        fontSize: 30.0),
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDetailWidget(
                                    title: "Nom secteur",
                                    subtitle:
                                        widget.versementModels.nomSecteur),
                                CustomDetailWidget(
                                    title: "Nom chef sercteur",
                                    subtitle:
                                        widget.versementModels.nomChefSecteur),
                              ]),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: Column(
                          children: [
                            CustomDetailWidget(
                                title: "Date versement",
                                subtitle: widget.versementModels.dateVersement),
                            CustomDetailWidget2(
                                title: "Somme verser",
                                controller: somme,
                                onChanged: (value) {
                                  valueIsChange();
                                }),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustumButton(
                          bacgroundColor:
                              isActive! ? Palette.teal : Colors.grey,
                          enableButton: isActive,
                          child: "  Enregistrez  ",
                          onPressed: () {
                            if (_versementModels.toString() !=
                                widget.versementModels.toString()) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .getUpadeteVersement(
                                      versementModels: _versementModels,
                                      context: context);
                            }
                          },
                        ),
                        CustumButton(
                            enableButton: true,
                            child: "   Fermer   ",
                            bacgroundColor: Palette.red,
                            onPressed: () async {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ))),
        ));
  }

  valueIsChange() {
    _versementModels = VersementModels(
        id: widget.versementModels.id,
        nomSecteur: widget.versementModels.nomSecteur,
        nomChefSecteur: widget.versementModels.nomChefSecteur,
        sommeVerser: somme.text,
        dateVersement: widget.versementModels.dateVersement,
        idSecteur: widget.versementModels.idSecteur,
        idChefSecteur: widget.versementModels.idChefSecteur);

    if (_versementModels.toString() != widget.versementModels.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}
