import 'package:flutter/material.dart';
import '../widgets/myprescribers_widget.dart';

class MyPrescribersPage extends StatefulWidget {
  const MyPrescribersPage({super.key});
  static String get routeName => 'myprescribers';
  static String get routeLocation => '/$routeName';

  @override
  State<MyPrescribersPage> createState() => _MyPrescribersPageState();
}

String qrcode = '';

class _MyPrescribersPageState extends State<MyPrescribersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Prescribers'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: MyPrescribers(),
      ),
    );
  }
}
