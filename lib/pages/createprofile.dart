import 'package:flutter/material.dart';
import 'package:synapserx_patient/widgets/userprofile_widget.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  static String get routeName => 'createprofile';
  static String get routeLocation => '/$routeName';

  @override
  State<CreateProfilePage> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const UserProfileWidget(title: 'Create Profile', isCreating: true);
  }
}
