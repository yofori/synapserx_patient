import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/providers/prescribers_provider.dart';
import '../providers/network_connectivity_provider.dart';
import '../providers/prescriptions_provider.dart';
import '../widgets/myprescribers_widget.dart';
import '../widgets/offlineindicator.dart';
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
    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return Scaffold(
      floatingActionButton:
          (connectivityStatusProvider == ConnectivityStatus.isConnected)
              ? FloatingActionButton(
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
                  })
              : null,
      appBar: AppBar(
        title: const Text('My Prescribers'),
      ),
      body: Column(
        children: [
          (connectivityStatusProvider == ConnectivityStatus.isConnected)
              ? Container()
              : const OfflineIndicator(),
          Expanded(
            flex: 1,
            child: RefreshIndicator(
                onRefresh: () async {
                  ref
                      .read(prescriptionsProvider.notifier)
                      .refreshPrescription();
                },
                child: const MyPrescribers()),
          ),
        ],
      ),
    );
  }
}
