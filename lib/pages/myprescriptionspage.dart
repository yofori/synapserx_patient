import 'package:flutter/material.dart';

import '../widgets/prescriptions_widget.dart';

class MyPrescriptionsPage extends StatefulWidget {
  const MyPrescriptionsPage({super.key});
  static String get routeName => 'myprescriptions';
  static String get routeLocation => '/$routeName';

  @override
  State<StatefulWidget> createState() => _MyPrescriptionsPageState();
}

class _MyPrescriptionsPageState extends State<MyPrescriptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MyPrescriptionsWidget(),
    );
  }
}
