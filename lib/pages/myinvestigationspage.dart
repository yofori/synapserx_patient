import 'package:flutter/material.dart';

class MyInvestigationsPage extends StatefulWidget {
  const MyInvestigationsPage({super.key});
  static String get routeName => 'investigations';
  static String get routeLocation => '/$routeName';

  @override
  State<StatefulWidget> createState() => _MyInvestigationsPageState();
}

class _MyInvestigationsPageState extends State<MyInvestigationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Scaffold(),
    );
  }
}
