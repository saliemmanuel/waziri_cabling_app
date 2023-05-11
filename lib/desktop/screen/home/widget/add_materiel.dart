import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/global_widget/add_image_card.dart';
import 'package:waziri_cabling_app/global_widget/custom_detail_widget.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';
import 'package:waziri_cabling_app/models/materiel_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_button.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/custum_textField.dart';
import '../provider/home_provider.dart';

class AddMateriel extends StatefulWidget {
  const AddMateriel({super.key});

  @override
  State<AddMateriel> createState() => _AddMaterielState();
}

class _AddMaterielState extends State<AddMateriel> {
  var designation = TextEditingController();
  var prix = TextEditingController();
  dynamic selectedDate;
  dynamic fileImageMateriel;
  bool imageIsLoading = false;
  dynamic fileImageFacture;
  bool factureIsLoading = false;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: InkWell(
        child: const Icon(Icons.close, color: Colors.white),
        onTap: () {
          Navigator.pop(context);
          Provider.of<HomeProvider>(context, listen: false).provideMateriels();
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
                    data: "Ajout matériel", color: Colors.red, fontSize: 30.0),
                const SizedBox(height: 25.0),
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
                                child:
                                    CustomText(data: "Désignation matériel")),
                          ),
                          CustumTextField(
                              controller: designation,
                              bacgroundColor: Palette.teal,
                              child: 'Désignation',
                              obscureText: false),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Prix achat matériel")),
                          ),
                          CustumTextField(
                              child: 'Prix',
                              controller: prix,
                              obscureText: false),
                          CustomDetailWidget(
                            title: "Date Achat",
                            nullVal: "Date",
                            subtitle: selectedDate,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          const SizedBox(height: 90.0)
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Image matériel")),
                          ),
                          AddImageCard(
                              child: InkWell(
                            child: SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: imageIsLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : fileImageMateriel == null
                                        ? const SizedBox(child: Icon(Icons.add))
                                        : buildFile(fileImageMateriel)),
                            onTap: () => _pickImgMaterielFiles(),
                          )),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(data: "Facture matériel")),
                          ),
                          AddImageCard(
                              child: InkWell(
                            child: SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: factureIsLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : fileImageFacture == null
                                        ? const SizedBox(child: Icon(Icons.add))
                                        : buildFile(fileImageFacture)),
                            onTap: () => _pickFactureFiles(),
                          )),
                        ],
                      ),
                    )
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
                          Provider.of<HomeProvider>(context, listen: false)
                              .addMateriel(
                                  materiel: MaterielModels(
                                      id: 0,
                                      designationMateriel: designation.text,
                                      prixMateriel: prix.text,
                                      imageMateriel: fileImageMateriel.path,
                                      dateAchatMateriel:
                                          selectedDate.toString(),
                                      factureMateriel: fileImageFacture.path,
                                      createAt: DateTime.now().toString()),
                                  context: context);
                          Provider.of<HomeProvider>(context, listen: false)
                              .provideMateriels();
                        }),
                    CustumButton(
                        enableButton: true,
                        child: "   Fermer   ",
                        bacgroundColor: Palette.red,
                        onPressed: () async {
                          Navigator.pop(context);
                          Provider.of<HomeProvider>(context, listen: false)
                              .provideMateriels();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickFactureFiles() async {
    setState(() {
      factureIsLoading = true;
    });

    try {
      var temp = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        type: FileType.custom,
      );
      PlatformFile file = temp!.files.first;
      setState(() {
        if (!mounted) return;
        fileImageFacture = file;
        factureIsLoading = false;
      });
    } on PlatformException catch (e) {
      errorDialogueCard('Error', e.toString(), context);
    } catch (e) {
      errorDialogueCard('Error', e.toString(), context);
    }
  }

  void _pickImgMaterielFiles() async {
    setState(() {
      imageIsLoading = true;
    });

    try {
      var temp = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        type: FileType.custom,
      );
      PlatformFile file = temp!.files.first;
      setState(() {
        if (!mounted) return;
        fileImageMateriel = file;
        imageIsLoading = false;
      });
    } on PlatformException catch (e) {
      errorDialogueCard('Error', e.toString(), context);
    } catch (e) {
      errorDialogueCard('Error', e.toString(), context);
    }
  }

  buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final filesize =
        mb > 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} Ko';
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${file.name} '),
          Text(filesize),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = '${picked.day}-${picked.month}-${picked.year} ';
      });
    }
  }
}
