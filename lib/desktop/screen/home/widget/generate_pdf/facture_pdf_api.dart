import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:waziri_cabling_app/api/service_api.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';

class FacturePdfApi {
  static generateFacture(List listFacture, var context) async {
    final imageJpg = (await rootBundle.load('assets/images/banners.png'))
        .buffer
        .asUint8List();
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        for (var i = 0; i < listFacture.length; i++)
          Column(children: [
            SizedBox(height: 5.0),
            i > 0 ? dotLine() : SizedBox(),
            SizedBox(height: 5.0),
            Image(MemoryImage(imageJpg),
                width: 500.0, fit: BoxFit.fill, height: 50.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("FACTURE N° : ${listFacture[i]['numero_facture']}"),
              Text("Du : ${listFacture[i]['created_at']}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                  "Nom et prénom: ${listFacture[i]['nom_abonne']} ${listFacture[i]['prenom_abonne']}"),
              Text("Type abonnement : ${listFacture[i]['type_abonnement']}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                  "Téléphone: ${listFacture[i]['telephone_abonne']} ${listFacture[i]['prenom_abonne']}"),
              Text("Nombre de chaine ${listFacture[i]['nombre_chaine']}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                  "CNI : ${listFacture[i]['cni_abonne']} ${listFacture[i]['prenom_abonne']}"),
              Text("Montant abonnement : ${listFacture[i]['montant']}"),
            ]),
            Row(children: [
              Text("Secteur : ${listFacture[i]['secteur_abonne']}"),
            ]),
            Row(children: [
              Text(
                  "Description : ${listFacture[i]['description_zone_abonne']} "),
            ]),
            SizedBox(height: 5.0),
            Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Désignantion"),
                      Text("Montant ${listFacture[i]['mensualite_facture']} "),
                    ])),
            Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mensualité facture : "),
                      Text(" ${listFacture[i]['mensualite_facture']} "),
                    ])),
            Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("impayes : "),
                      Text("${listFacture[i]['impayes']} "),
                    ])),
            Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Net à payer : "),
                      Text(
                          "${int.parse(listFacture[i]['impayes']) + int.parse(listFacture[i]['mensualite_facture'])} "),
                    ])),
          ]),
      ],
    ));

    return saveDocument(
        context: context,
        name:
            'facture_bw_du_${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}${DateTime.now().minute}.pdf',
        pdf: pdf);
  }

  static dotLine() {
    return Row(
      children: List.generate(
          100,
          (index) => Expanded(
                  child: Container(
                color: index == 0
                    ? PdfColor.fromHex('#FFFFFF')
                    : index % 2 == 0
                        ? PdfColor.fromHex('#FFFFFF')
                        : PdfColor.fromHex('#000000'),
                height: 1,
                width: 0.5,
              ))),
    );
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
    required var context,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    try {
      succesTransaction(
          'Facture générer avec succes et enrégistré dans ${dir.path}',
          context);
      await file.writeAsBytes(bytes);
    } catch (e) {
      print(e);
    }
    return file;
  }
}
