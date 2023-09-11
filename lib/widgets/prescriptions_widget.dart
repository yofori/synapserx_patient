import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:synapserx_patient/pages/displayprescription.dart';

import '../providers/prescriptions_provider.dart';

class MyPrescriptionsWidget extends ConsumerStatefulWidget {
  const MyPrescriptionsWidget({super.key});
  @override
  ConsumerState<MyPrescriptionsWidget> createState() =>
      _MyPrescriptionsWidgetState();
}

class _MyPrescriptionsWidgetState extends ConsumerState<MyPrescriptionsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionsList = ref.watch(prescriptionsProvider);
    return prescriptionsList.when(
        data: (prescriptions) => prescriptions.isNotEmpty
            ? ListView.builder(
                itemCount: prescriptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayRxPage(
                                    prescription: prescriptions[index],
                                  )));
                    },
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.deepPurple, width: 2),
                      ),
                      child: Center(
                          child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(fontSize: 16),
                      )),
                    ),
                    title: Text(
                        'Date: ${DateFormat('dd-MM-yyyy @ hh:mm a').format(DateTime.parse(prescriptions[index].createdAt.toString()))}'),
                    subtitle: Text(
                        'Prescriber: ${prescriptions[index].prescriberName}'),
                    // trailing: IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(Icons.more_vert)),
                  );
                },
              )
            : const Center(
                child: Text(
                  'You do not have any prescriptions yet.',
                  textAlign: TextAlign.center,
                ),
              ),
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: const Center(child: CircularProgressIndicator())));
  }
}
