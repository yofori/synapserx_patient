import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/network_connectivity_provider.dart';
import '../providers/prescriptions_provider.dart';
import '../widgets/offlineindicator.dart';
import '../widgets/prescriptions_widget.dart';

class MyPrescriptionsPage extends ConsumerWidget {
  const MyPrescriptionsPage({super.key});
  static String get routeName => 'myprescriptions';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Prescriptions'),
        actions: [
          IconButton(
              onPressed: () async {
                ref.read(prescriptionsProvider.notifier).refreshPrescription();
              },
              icon: const Icon(Icons.refresh))
        ],
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
                child: const MyPrescriptionsWidget()),
          ),
        ],
      ),
    );
  }
}
