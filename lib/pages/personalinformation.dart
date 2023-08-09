import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/userprofile_widget.dart';

class PersonalInfoPage extends ConsumerStatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);
  static String get routeName => 'personalinfo';
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends ConsumerState<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return const UserProfileWidget(
        title: 'Personal Information', isCreating: false);
  }
}
