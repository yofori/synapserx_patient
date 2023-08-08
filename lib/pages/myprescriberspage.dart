import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:synapserx_patient/widgets/qrcodecapture.dart';
import '../widgets/myprescribers_widget.dart';

class MyPrescribersPage extends StatefulWidget {
  const MyPrescribersPage({super.key});
  static String get routeName => 'myprescribers';
  static String get routeLocation => '/$routeName';

  @override
  State<MyPrescribersPage> createState() => _MyPrescribersPageState();
}

String qrcode = '';

class _MyPrescribersPageState extends State<MyPrescribersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add),
          onPressed: () async {
            qrcode = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BarcodeScanner(
                        title: 'Scan Prescriber QR Code',
                      )),
            );
            log(qrcode);
          }),
      appBar: AppBar(
        title: const Text('My Prescribers'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: MyPrescribers(),
      ),
    );
  }
}
