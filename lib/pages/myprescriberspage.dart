import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/providers/prescribers_provider.dart';
import '../widgets/myprescribers_widget.dart';
import '../widgets/qrcodecapture.dart';

class MyPrescribersPage extends ConsumerStatefulWidget {
  const MyPrescribersPage({super.key});
  static String get routeName => 'myprescribers';
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<MyPrescribersPage> createState() => _MyPrescribersPageState();
}

String qrcode = '';

class _MyPrescribersPageState extends ConsumerState<MyPrescribersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            qrcode = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BarcodeScanner(
                            title: 'Scan Prescriber QR Code',
                          )),
                ) ??
                '';
            if (qrcode.isNotEmpty) {
              await ref
                  .read(prescribersProvider.notifier)
                  .addPrescriber(qrcode);
            }
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
