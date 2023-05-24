// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/action_dialogue.dart';
import 'package:waziri_cabling_app/global_widget/custom_detail_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'package:waziri_cabling_app/models/materiel_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/add_image_card.dart';
import '../../../../global_widget/custom_detail_widget_2.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../provider/home_provider.dart';

class DetailMateriel extends StatefulWidget {
  final MaterielModels materiel;
  const DetailMateriel({
    Key? key,
    required this.materiel,
  }) : super(key: key);

  @override
  State<DetailMateriel> createState() => _DetailMaterielState();
}

class _DetailMaterielState extends State<DetailMateriel> {
  late TextEditingController designation;
  late TextEditingController prix;
  MaterielModels? _materiel;
  dynamic selectedDate;
  bool imageIsLoading = false;
  dynamic fileImageFacture;
  dynamic fileImageMateriel;

  bool factureIsLoading = false;
  bool? isActive = false;
  bool? activePreviewImg = true;
  bool? activeChangeImg = false;
  bool? activePreviewFac = true;
  bool? activeChangeFac = false;
  @override
  void initState() {
    designation =
        TextEditingController(text: widget.materiel.designationMateriel);
    prix = TextEditingController(text: widget.materiel.prixMateriel);

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
          width: 900.0,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDetailWidget2(
                                  title: "Désignation matériel",
                                  controller: designation,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              const SizedBox(height: 10.0),
                              CustomDetailWidget2(
                                  title: "Prix achat matériel",
                                  controller: prix,
                                  onChanged: (value) {
                                    valueIsChange();
                                  }),
                              const SizedBox(height: 10.0),
                              CustomDetailWidget(
                                title: "Date achat matériel",
                                nullVal: widget.materiel.dateAchatMateriel,
                                subtitle: selectedDate,
                                onTap: () {
                                  _selectDate(context);
                                },
                              ),
                              const SizedBox(height: 10.0),
                              CustomDetailWidget(
                                  title: "Date enrégistrement matériel",
                                  subtitle: widget.materiel.createAt),
                              const SizedBox(height: 90.0),
                            ]),
                      ),
                      const SizedBox(width: 35.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(data: "Image matériel")),
                            ),
                            Visibility(
                              visible: activePreviewImg!,
                              child: Badge(
                                largeSize: 24.0,
                                backgroundColor: Palette.transparent,
                                label: IconButton(
                                    onPressed: () {
                                      _pickImgMaterielFiles();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    )),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Helper(
                                      value: widget.materiel.imageMateriel!
                                          .split("/")
                                          .last
                                          .contains('.pdf'),
                                      fileName: widget.materiel.imageMateriel!,
                                    )),
                              ),
                            ),
                            Visibility(
                              visible: activeChangeImg!,
                              child: Badge(
                                largeSize: 30.0,
                                backgroundColor: Palette.transparent,
                                label: IconButton(
                                    onPressed: () {
                                      removeChangeImg();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                child: AddImageCard(
                                    child: InkWell(
                                  child: SizedBox(
                                      height: 100.0,
                                      width: 100.0,
                                      child: imageIsLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : fileImageMateriel == null
                                              ? const SizedBox(
                                                  child: Icon(Icons.add))
                                              : buildFile(fileImageMateriel)),
                                  onTap: () => _pickImgMaterielFiles(),
                                )),
                              ),
                            ),
                            // Facture
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, bottom: 10.0, top: 30.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(data: "Facture matériel")),
                            ),
                            Visibility(
                              visible: activePreviewFac!,
                              child: Badge(
                                largeSize: 24.0,
                                backgroundColor: Palette.transparent,
                                label: IconButton(
                                    onPressed: () {
                                      _pickFactureFiles();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    )),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Helper(
                                      value: widget.materiel.factureMateriel!
                                          .split("/")
                                          .last
                                          .contains('.pdf'),
                                      fileName:
                                          widget.materiel.factureMateriel!,
                                    )),
                              ),
                            ),
                            Visibility(
                              visible: activeChangeFac!,
                              child: Badge(
                                largeSize: 30.0,
                                backgroundColor: Palette.transparent,
                                label: IconButton(
                                    onPressed: () {
                                      removeChangeFac();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                child: AddImageCard(
                                    child: InkWell(
                                  child: SizedBox(
                                      height: 100.0,
                                      width: 100.0,
                                      child: factureIsLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : fileImageFacture == null
                                              ? const SizedBox(
                                                  child: Icon(Icons.add))
                                              : buildFile(fileImageFacture)),
                                  onTap: () => _pickFactureFiles(),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 55.0),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustumButton(
                        bacgroundColor: isActive! ? Palette.teal : Colors.grey,
                        enableButton: isActive,
                        child: "  Enregistrez  ",
                        onPressed: () {
                          valueIsChange();
                          if (_materiel.toString() !=
                              widget.materiel.toString()) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .getUpdateMateriel(
                                    materiel: _materiel, context: context);
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
                      const SizedBox(width: 55.0),
                    ],
                  ),
                ],
              ))),
        ));
  }

  void _pickFactureFiles() async {
    setState(() {
      factureIsLoading = true;
      activePreviewFac = false;
      activeChangeFac = true;
      isActive = true;
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

  removeChangeImg() {
    setState(() {
      imageIsLoading = false;
      activePreviewImg = true;
      activeChangeImg = false;
      isActive = false;
    });
  }

  removeChangeFac() {
    setState(() {
      factureIsLoading = false;
      activePreviewFac = true;
      activeChangeFac = false;
      isActive = false;
    });
  }

  void _pickImgMaterielFiles() async {
    setState(() {
      imageIsLoading = true;
      activePreviewImg = false;
      activeChangeImg = true;
      isActive = true;
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
        valueIsChange();
      });
    }
  }

  valueIsChange() {
    _materiel = MaterielModels(
        id: widget.materiel.id,
        dateAchatMateriel: selectedDate ?? widget.materiel.dateAchatMateriel,
        designationMateriel: designation.text,
        prixMateriel: prix.text,
        factureMateriel:
            fileImageFacture != null ? fileImageFacture.path : fileImageFacture,
        imageMateriel: fileImageMateriel != null
            ? fileImageMateriel.path
            : fileImageMateriel,
        createAt: widget.materiel.createAt);

    if (_materiel.toString() != widget.materiel.toString()) {
      isActive = true;
    } else {
      isActive = false;
    }
    setState(() {});
  }
}

class Helper extends StatefulWidget {
  const Helper({super.key, required this.value, required this.fileName});
  final bool value;
  final String fileName;

  @override
  State<Helper> createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  var pourcent = "0";

  @override
  Widget build(BuildContext context) {
    return widget.value
        ? ListTile(
            title: Text(widget.fileName),
            trailing:
                pourcent == "0" ? const Icon(Icons.download) : Text(pourcent),
            onTap: () async {
              var tempDir = await getApplicationDocumentsDirectory();
              String fullPath =
                  "${tempDir.path}/${widget.fileName.split('/').last}";
              download(widget.fileName, fullPath);
              if (pourcent == "100") {
                errorDialogueCard("Téléchargement",
                    'Fichier enregistré dans $fullPath', context);
              }
            },
          )
        : InkWell(
            child: Container(
                height: 215.0,
                width: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Palette.primaryColor),
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.fileName,
                        ),
                        fit: BoxFit.cover))),
            onTap: () {
              actionDialogue(
                  child: SizedBox(
                      width: 500.0,
                      child: PhotoView(
                          backgroundDecoration:
                              const BoxDecoration(color: Colors.white),
                          imageProvider: NetworkImage(widget.fileName))),
                  context: context);
            });
  }

  Future download(String url, String savePath) async {
    var dio = Dio();
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
      setState(() {
        pourcent = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }
}
