import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import '../services/pdf_prescription_api.dart' as pdfgen;
import '../models/prescription.dart';
import '../services/pdf_api.dart';

class DisplayRxPage extends StatefulWidget {
  const DisplayRxPage({super.key, required this.prescription});
  static String get routeName => 'displayprescription';
  static String get routeLocation => '/$routeName';

  final Prescription prescription;

  @override
  State<DisplayRxPage> createState() => _DisplayRxPageState();
}

class _DisplayRxPageState extends State<DisplayRxPage> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final pdfFile = await pdfgen.PdfPrescriptionApi.generate(
                      widget.prescription);
                  // ignore: use_build_context_synchronously
                  PdfApi.sharePDF(context, pdfFile, 'Your Prescription');
                  //PdfApi.openFile(pdfFile);
                },
                icon: const Icon(Icons.share))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: BarcodeWidget(
                    data: widget.prescription.sId.toString(),
                    barcode: Barcode.qrCode(),
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'PRESCRIPTION',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                              width: 100,
                              child: Text(
                                'Name:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                              child: Text(
                                  '${widget.prescription.pxFirstname} ${widget.prescription.pxSurname}')),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        const SizedBox(
                            width: 100,
                            child: Text(
                              'Age/Gender:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                            child: Text(
                                '${widget.prescription.pxAge}yrs / ${widget.prescription.pxgender}')),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rx',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(child: buildPrescription(widget.prescription)),
                      Center(
                        child: buildFooter(widget.prescription),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildPrescription(Prescription prescription) {
    int i = 1;
    List<DataColumn> createColumns() {
      return [
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomLeft,
                //width: width * .05,
                height: 20,
                child: const Text('#'))),
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomLeft,
                //width: width * .38,
                height: 20,
                child: const Text('Name of Medication'))),
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomLeft,
                //width: width * .15,
                height: 20,
                child: const Text('Dose'))),
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomCenter,
                //width: width * .15,
                height: 20,
                child: const Text('Dosage'))),
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomLeft,
                //width: width * .19,
                height: 20,
                child: const Text('Duration'))),
      ];
    }

    List<DataRow> createrows() {
      return prescription.medications!
          .map((item) => DataRow(cells: [
                DataCell(Container(
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${(i++)}',
                      softWrap: true,
                    ))),
                DataCell(Container(
                  margin: const EdgeInsets.all(3),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${item.drugName} ${item.directionOfUse == null || item.directionOfUse.toString().trim() == '' ? '' : '\n \n Sig: ${item.directionOfUse.toString()}'}',
                    softWrap: true,
                  ),
                )),
                DataCell(Container(
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.topLeft,
                    child: Text('${item.dose} ${item.dosageUnits}',
                        softWrap: true))),
                DataCell(Container(
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.topCenter,
                    child: Text(
                      '${item.dosageRegimen}',
                      softWrap: true,
                    ))),
                DataCell(Container(
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${item.duration} ${item.durationUnits}',
                      softWrap: true,
                    ))),
              ]))
          .toList();
    }

    return SizedBox(
      width: width,
      child: DataTable(
          //headingTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          showBottomBorder: true,
          headingRowHeight: 30,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey),
          dataRowHeight: 75,
          border: TableBorder.all(width: 0.5),
          columnSpacing: 0,
          horizontalMargin: 0,
          columns: createColumns(),
          rows: createrows()),
    );
  }

  static Widget buildFooter(Prescription prescription) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Divider(
          //   thickness: 1,
          // ),
          const SizedBox(
            height: 20,
          ),
          buildSimpleText(
              title: 'Prescriber: ',
              value: prescription.prescriberName.toString()),
          const SizedBox(height: 5),
          buildSimpleText(
              title: 'Reg No: ',
              value: prescription.prescriberMDCRegNo.toString()),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    const style = TextStyle(fontWeight: FontWeight.bold);

    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(title, style: style),
          ),
          const SizedBox(width: 20),
          Text(value),
        ],
      ),
    );
  }
}
