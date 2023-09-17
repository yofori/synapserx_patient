import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/providers/userprofile_provider.dart';

import '../widgets/alert_msg_widget.dart';

class QRPage extends ConsumerWidget {
  const QRPage({super.key});

  static String get routeName => 'myqrpage';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(asyncUserProfileProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My QR Code'),
        ),
        body: profileProvider.when(
          data: (profile) {
            return Padding(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BarcodeWidget(
                      barcode: Barcode.qrCode(), // Barcode type and settings
                      data: profile.patientuid.toString(), // Content
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Show this QR Code to your prescriber to add you as as patient in their synapseRx App',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
          error: (err, stack) => Center(
            child: AlertMSGWidget(
              showActionButton: true,
              imageLocation: 'assets/images/error_graphic.png',
              subtitle: err.toString(),
              title: 'Unable to retrieve your QR Code',
              action: () {
                ref.read(asyncUserProfileProvider.notifier).refreshProfile();
              },
              actionButtonText: 'Retry',
            ),
          ),
          loading: (() => const Center(child: CircularProgressIndicator())),
        ));
  }
}
