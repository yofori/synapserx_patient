import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/providers/labrequests_provider.dart';

import '../providers/network_connectivity_provider.dart';
import '../widgets/labrequests_widget.dart';
import '../widgets/offlineindicator.dart';

class MyInvestigationsPage extends ConsumerWidget {
  const MyInvestigationsPage({super.key});
  static String get routeName => 'investigations';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Lab Investigations'),
          actions: [
            IconButton(
                onPressed: () async {
                  ref
                      .read(labRequestsProvider.notifier)
                      .refreshLabinvestigations();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: Column(children: [
          (connectivityStatusProvider == ConnectivityStatus.isConnected)
              ? Container()
              : const OfflineIndicator(),
          Expanded(
            flex: 1,
            child: RefreshIndicator(
              onRefresh: () async {
                ref
                    .read(labRequestsProvider.notifier)
                    .refreshLabinvestigations();
              },
              child: const MyLabsWidget(),
            ),
          ),
        ]));
  }
}
