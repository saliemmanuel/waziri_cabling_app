import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:path_provider/path_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_dialogue_card.dart';

class FacturePdfApi {
  generateFacture(List listFacture, var context, {var title}) async {
    final imageJpg = (await rootBundle.load('assets/images/banners.png'))
        .buffer
        .asUint8List();
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        for (var i = 0; i < listFacture.length; i++)
          if (int.parse(DateTime.now().month.toString().split('-')[0]) ==
              int.parse(listFacture[i]['create_fm'].toString().split('-')[1]))
            Column(children: [
              SizedBox(height: 5.0),
              i > 0 ? dotLine() : SizedBox(),
              SizedBox(height: 5.0),
              Image(MemoryImage(imageJpg),
                  width: 498.0, fit: BoxFit.fill, height: 95.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: PdfColors.black)),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "FACTURE N° : ${listFacture[i]['numero_facture']}",
                                      style: const TextStyle(fontSize: 10.0)),
                                ]),
                            SizedBox(height: 5.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Du : ${listFacture[i]['created_at']}",
                                      style: const TextStyle(fontSize: 10.0)),
                                ]),
                            SizedBox(height: 5.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Nom et prénom: ${listFacture[i]['nom_abonne']} ${listFacture[i]['prenom_abonne']}",
                                      style: const TextStyle(fontSize: 10.0)),
                                ]),
                            SizedBox(height: 5.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Téléphone: ${listFacture[i]['telephone_abonne']} ",
                                      style: const TextStyle(fontSize: 10.0)),
                                ]),
                            SizedBox(height: 5.0),
                            Row(children: [
                              Text(
                                  "Secteur : ${listFacture[i]['secteur_abonne']}",
                                  style: const TextStyle(fontSize: 10.0)),
                            ]),
                            SizedBox(height: 5.0),
                            Row(children: [
                              Text(
                                  "Type abonnement : ${listFacture[i]['type_abonnement']}",
                                  style: const TextStyle(fontSize: 10.0))
                            ]),
                            SizedBox(height: 5.0),
                            Row(children: [
                              Text(
                                  "Description : ${listFacture[i]['description_zone_abonne']}",
                                  style: const TextStyle(fontSize: 10.0)),
                            ]),
                            SizedBox(height: 15.0),
                            Table.fromTextArray(
                              tableWidth: TableWidth.max,
                              headers: ['DESIGNATION', 'MONTANT'],
                              data: [
                                [
                                  'MENSUALITE',
                                  '${listFacture[i]['mensualite_facture']}'
                                ],
                                ['IMPAYES', '${listFacture[i]['impayes']}'],
                                [
                                  'NET A PAYER :',
                                  '${int.parse(listFacture[i]['impayes']) + int.parse(listFacture[i]['mensualite_facture'])}'
                                ],
                                [
                                  'OBSERVATION',
                                  int.parse(listFacture[i]['impayes']) +
                                              int.parse(listFacture[i]
                                                  ['mensualite_facture']) >
                                          5500
                                      ? "A COUPER"
                                      : "RAS"
                                ],
                              ],
                              border: null,
                              cellHeight: 10.0,
                              headerHeight: 10,
                              cellStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 8.0),
                              headerStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 8.0),
                              headerDecoration:
                                  const BoxDecoration(color: PdfColors.grey300),
                              cellAlignments: {
                                0: Alignment.centerLeft,
                                1: Alignment.centerRight
                              },
                            ),
                            SizedBox(height: 3.5),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: PdfColors.black)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("MESSAGE IMPORTANT !!!",
                                      style: TextStyle(
                                          fontSize: 8.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 7.0),
                                  Text("PAYER VOS FACTURE AINSI",
                                      style: TextStyle(
                                          fontSize: 7.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 7.0),
                                  Row(children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        color: PdfColors.orange),
                                    Text(
                                        "    Orange Money : \n\n    #150*40*##########*montant#",
                                        style: const TextStyle(fontSize: 7.0)),
                                  ]),
                                  SizedBox(height: 7.0),
                                  Row(children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        color: PdfColors.yellow),
                                    Text(
                                        "    MTN MoMo : \n\n    *126*4*##########*montant#",
                                        style: const TextStyle(fontSize: 7.0)),
                                  ]),
                                  SizedBox(height: 7.0),
                                  Text("ETS BW IMAGE",
                                      style: TextStyle(
                                          fontSize: 7.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 7.0),
                                  Text(
                                      "TOUT PAIEMENT EN ESPECES DOIT SE FAIRE DANS NOUS BUREAU, MUNI DE CETTE FACTURE; EXIGER UN RECU EN CONTRE PARTIE",
                                      style: const TextStyle(fontSize: 7.0)),
                                  SizedBox(height: 7.0),
                                  Text(
                                      "Nous déclinons nos responsabilités pour toutes transaction financières faites sans réçu.",
                                      style: const TextStyle(fontSize: 7.0)),
                                  SizedBox(height: 7.0),
                                  Row(children: [
                                    Text("DATE LIMITE DE PAIEMENT :",
                                        style: TextStyle(
                                            fontSize: 7.0,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                  SizedBox(height: 6.0),
                                  Text(
                                      "AVIS DE COUPURES/COUPURES SANS PREAVIS A PARTIR DU :",
                                      style: TextStyle(
                                          fontSize: 7.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 7.0),
                                  Text(
                                      "Tout paiement effectué après la date de coupure, sera toujours majoré des frais de coupure d'un montant de 1500 FCFA. Le délai de reconnections est de 05 jours après paiement",
                                      style: const TextStyle(fontSize: 7.0)),
                                ])))
                  ]),
              SizedBox(height: 2.0),
              Row(children: [
                Text(
                    "BW IMAGE situé vers l'avenue deux voix kakatare Maroua à côté de la maison Canal +\nContact :655555554 E-mail : bw-image@waziri-cablingapp.com",
                    style: const TextStyle(fontSize: 6.0)),
              ])
            ]),
      ],
    ));

    return saveDocument(
        context: context,
        name: title ??
            'facture_bw_du_${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}.pdf',
        pdf: pdf);
  }

  static dotLine() {
    return Row(
      children: List.generate(
          100,
          (index) => Expanded(
                  child: Container(
                color: index == 0
                    ? PdfColors.white
                    : index % 2 == 0
                        ? PdfColors.white
                        : PdfColors.grey,
                height: 1,
                width: 0.5,
              ))),
    );
  }

  saveDocument({
    required String name,
    required Document pdf,
    required var context,
  }) async {
    try {
      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');
      succesTransaction(
          'Facture générer avec succes et enrégistré dans ${dir.path}',
          context);

      await file.writeAsBytes(bytes);
    } catch (e) {
      succesTransaction('$e', context);
    }
  }
}
