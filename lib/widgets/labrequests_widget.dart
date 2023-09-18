import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../pages/displaylabinvestigation.dart';
import '../providers/labrequests_provider.dart';
import 'alert_msg_widget.dart';

class MyLabsWidget extends ConsumerStatefulWidget {
  const MyLabsWidget({super.key});
  @override
  ConsumerState<MyLabsWidget> createState() => _MyLabsWidgetState();
}

class _MyLabsWidgetState extends ConsumerState<MyLabsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labList = ref.watch(labRequestsProvider);
    return labList.when(
        data: (labinvestigations) => labinvestigations.isNotEmpty
            ? ListView.builder(
                itemCount: labinvestigations.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayLabInvestigationPage(
                                    labRequest: labinvestigations[index],
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
                        'Date: ${DateFormat('dd-MM-yyyy @ hh:mm a').format(DateTime.parse(labinvestigations[index].createdAt.toString()))}'),
                    subtitle: Text(
                        'Prescriber: ${labinvestigations[index].prescriberName}'),
                  );
                },
              )
            : const Center(
                child: Text(
                  'You do not have any labinvestigations yet.',
                  textAlign: TextAlign.center,
                ),
              ),
        error: (err, stack) => Center(
              child: AlertMSGWidget(
                showActionButton: true,
                imageLocation: 'assets/images/error_graphic.png',
                subtitle: err.toString(),
                title: 'Unable to retrieve your lab investigation',
                action: () {
                  ref
                      .read(labRequestsProvider.notifier)
                      .refreshLabinvestigations();
                },
                actionButtonText: 'Retry',
              ),
            ),
        loading: () => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: const Center(child: CircularProgressIndicator())));
  }
}
