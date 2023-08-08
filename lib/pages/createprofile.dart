import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/widgets/userprofile_widget.dart';

import '../providers/userprofile_provider.dart';
import '../services/dio_client.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  static String get routeName => 'createprofile';
  static String get routeLocation => '/$routeName';

  @override
  State<CreateProfilePage> createState() => _CreateProfileState();
}

var params = {};

class _CreateProfileState extends State<CreateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
            )),
        title: const Text('Create Profile'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final value = ref.watch(isSaveButtonEnabledProvider);
              return value
                  ? TextButton(
                      onPressed: () async {
                        await ref
                            .watch(dioClientProvider)
                            .createProfileInfo(data: params)
                            .then((updateOutcome) {
                          if (updateOutcome) {
                            ref
                                .watch(isSaveButtonEnabledProvider.notifier)
                                .saveEnabled(false);
                            ref.invalidate(asyncUserProfileProvider);
                          }
                        });
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ))
                  : Container();
            },
          ),
        ],
      ),
      body: const UserProfileWidget(),
    );
  }
}
