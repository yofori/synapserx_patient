import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import '../models/labrequest.dart';
import 'pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'stringutils.dart';

class PdfLabRequestApi {
  static Future<File> generate(LabRequest labrequest) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
      header: (context) => buildHeader(labrequest),
      build: (context) => [
        buildPrescription(labrequest),
      ],
      footer: (context) => buildFooter(labrequest),
    ));

    return PdfApi.saveDocument(name: labrequest.sId.toString(), pdf: pdf);
  }

  static Widget buildHeader(LabRequest labrequest) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //buildPrescriberAddress(prescription),
              buildTitle(labrequest),
              Container(
                height: 48,
                width: 48,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: labrequest.sId.toString(),
                ),
              ),
            ],
          ),
          //SizedBox(height: 1 * PdfPageFormat.cm),
          buildPatientAddress(labrequest),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildPatientAddress(LabRequest labrequest) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${labrequest.pxFirstname} ${labrequest.pxSurname}',
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 14, lineSpacing: 2)),
          SizedBox(height: 0.125 * PdfPageFormat.cm),
          Text(
              'Sex / Age: ${labrequest.pxAge}yrs / ${labrequest.pxgender.toCapitalized()}',
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 14, lineSpacing: 2)),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text(
              'Date: ${DateFormat('dd-MM-yyyy @ hh:mm a').format(DateTime.parse(labrequest.createdAt.toString()))}',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  lineSpacing: 1.5)),
        ],
      );

  static Widget buildPrescriberAddress(LabRequest labrequest) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labrequest.prescriberInstitutionName.toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(labrequest.prescriberInstitutionAddress.toString()),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(labrequest.prescriberInstitutionEmail == null ||
                  labrequest.prescriberInstitutionEmail.toString().trim() == ''
              ? ''
              : 'Email: ${labrequest.prescriberInstitutionEmail.toString()} ${labrequest.prescriberInstitutionEmail == null || labrequest.prescriberInstitutionEmail.toString().trim() == '' ? '' : 'Telephone: ${labrequest.prescriberInstitutionTelephone.toString()}'}'),
        ],
      );

  static Widget buildTitle(LabRequest labrequest) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text('LABORATORY REQUEST',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildPrescription(LabRequest labrequest) {
    int i = 1;
    final headers = [
      '#',
      'Analysis Request',
    ];
    final data = labrequest.requests!.map((item) {
      return [
        '${(i++)}',
        (item.orderedTestDescription),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      headerAlignments: {
        0: Alignment.bottomCenter,
        1: Alignment.bottomLeft,
      },
      cellHeight: 30,
      columnWidths: {1: const FixedColumnWidth(240)},
      cellAlignments: {
        0: Alignment.topLeft,
        1: Alignment.topLeft,
      },
    );
  }

  static Widget buildFooter(LabRequest labrequest) => Column(
        children: [
          buildSignature(labrequest),
          Divider(),
          Row(children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2 * PdfPageFormat.mm),
                  Text(labrequest.prescriberName.toString(),
                      textAlign: TextAlign.left),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  Text(labrequest.prescriberMDCRegNo.toString(),
                      textAlign: TextAlign.left),
                ]),
            SizedBox(width: 20),
            buildPrescriberAddress(labrequest),
          ]),
          SizedBox(height: 5),
          Divider(),
          SizedBox(
              child:
                  Text('This lab request was created using the synapseRx® App'))
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static String capitalizeAll(String text) {
    return text.replaceAllMapped(RegExp(r'\.\s+[a-z]|^[a-z]'), (m) {
      final String match = m[0] ?? '';
      return match.toUpperCase();
    });
  }

  static buildSignature(LabRequest labrequest) {
    Uint8List? signatureImage;
    if (labrequest.prescriberSignature == null ||
        labrequest.prescriberSignature == '') {
      return Container();
    } else {
      signatureImage = base64Decode(labrequest.prescriberSignature.toString());
      return Container(
          child: Row(children: <Widget>[
            Text('Requester\'s Signature: '),
            Image(MemoryImage(signatureImage))
          ]),
          height: 40);
    }
  }
}
