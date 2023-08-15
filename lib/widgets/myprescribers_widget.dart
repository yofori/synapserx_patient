import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/providers/prescribers_provider.dart';

class MyPrescribers extends ConsumerWidget {
  const MyPrescribers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescribersList = ref.watch(prescribersProvider);
    return prescribersList.when(
        data: (prescribers) => RefreshIndicator(
              onRefresh: () async {
                ref.refresh(prescribersProvider);
              },
              child: prescribers.isNotEmpty
                  ? ListView(
                      children: [
                        for (final prescriber in prescribers)
                          ListTile(
                            title: Text(prescriber.prescriberFullname),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                          )
                      ],
                    )
                  : const Center(
                      child: Text(
                        'You do not have any prescribers listed yet. Click the add button to scan a prescriber\'s QR Code',
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
