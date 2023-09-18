import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:synapserx_patient/models/labrequest.dart';
import '../main.dart';
import '../services/pdf_labrequest_api.dart' as pdfgen;
import '../services/pdf_api.dart';

class DisplayLabInvestigationPage extends StatefulWidget {
  const DisplayLabInvestigationPage({super.key, required this.labRequest});
  static String get routeName => 'displaylabinvestigation';
  static String get routeLocation => '/$routeName';

  final LabRequest labRequest;

  @override
  State<DisplayLabInvestigationPage> createState() =>
      _DisplayLabInvestigationPageState();
}

class _DisplayLabInvestigationPageState
    extends State<DisplayLabInvestigationPage> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lab Request'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  final pdfFile =
                      await pdfgen.PdfLabRequestApi.generate(widget.labRequest);
                  // ignore: use_build_context_synchronously
                  PdfApi.sharePDF(context, pdfFile, 'Your Lab Request');
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
                    data: widget.labRequest.sId.toString(),
                    barcode: Barcode.qrCode(),
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'ANALYSIS REQUEST',
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
                                  '${widget.labRequest.pxFirstname} ${widget.labRequest.pxSurname}')),
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
                                '${widget.labRequest.pxAge}yrs / ${widget.labRequest.pxgender}')),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(child: buildLabRequest(widget.labRequest)),
                      Center(
                        child: buildFooter(widget.labRequest),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildLabRequest(LabRequest labrequest) {
    double width = MediaQuery.of(context).size.width;
    int i = 1;
    List<DataColumn> createColumns() {
      return [
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomLeft,
                width: width * .05,
                height: 15,
                child: const Text('#'))),
        DataColumn(
            label: Container(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                alignment: Alignment.bottomLeft,
                width: width * .70,
                height: 15,
                child: const Text('Analysis Request'))),
      ];
    }

    List<DataRow> createrows() {
      return labrequest.requests!
          .map((item) => DataRow(cells: [
                DataCell(Container(
                    margin: const EdgeInsets.all(3),
                    alignment: Alignment.topLeft,
                    child: Text('${(i++)}'))),
                DataCell(Container(
                  margin: const EdgeInsets.all(3),
                  alignment: Alignment.topLeft,
                  child: Text(item.orderedTestDescription),
                )),
              ]))
          .toList();
    }

    return SizedBox(
      width: width,
      child: DataTable(
          //headingTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          showBottomBorder: true,
          headingRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey),
          dataRowHeight: 20,
          border: TableBorder.all(width: 0.5),
          columnSpacing: 0,
          horizontalMargin: 0,
          columns: createColumns(),
          rows: createrows()),
    );
  }

  static Widget buildFooter(LabRequest labRequest) => Column(
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
              value: labRequest.prescriberName.toString()),
          const SizedBox(height: 5),
          buildSimpleText(
              title: 'Reg No: ',
              value: labRequest.prescriberMDCRegNo.toString()),
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
