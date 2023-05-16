import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/action_dialogue.dart';
import 'package:waziri_cabling_app/global_widget/custom_detail_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'package:waziri_cabling_app/models/materiel_models.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Badge(
        label: InkWell(
          child: const Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        child: SizedBox(
          width: 800.0,
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
                              CustomDetailWidget(
                                  title: "Désignation matériel",
                                  subtitle:
                                      widget.materiel.designationMateriel),
                              CustomDetailWidget(
                                  title: "Prix achat matériel",
                                  subtitle: widget.materiel.prixMateriel),
                              CustomDetailWidget(
                                  title: "Date achat matériel",
                                  subtitle: widget.materiel.dateAchatMateriel),
                              CustomDetailWidget(
                                  title: "Date enrégistrement",
                                  subtitle: widget.materiel.createAt),
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
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Helper(
                                  value: widget.materiel.imageMateriel
                                      .split("/")
                                      .last
                                      .contains('.pdf'),
                                  fileName: widget.materiel.imageMateriel,
                                )),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, bottom: 10.0, top: 45.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(data: "Facture matériel")),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Helper(
                                  value: widget.materiel.factureMateriel
                                      .split("/")
                                      .last
                                      .contains('.pdf'),
                                  fileName: widget.materiel.factureMateriel),
                            ),
                            const SizedBox(height: 35.0),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ))),
        ));
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
              // ignore: use_build_context_synchronously
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
                width: 200.0,
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
      print(response.headers);
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
